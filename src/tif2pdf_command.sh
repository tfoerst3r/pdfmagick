#!/usr/bin/env bash
# SPDX-FileCopyrightText: Copyright (c) 2024 Thomas Förster
# SPDX-License-Identifier: MIT

#====================#
#== INITIALIZATION ==#
#====================#
local pdfarray=()
local _flag_one_output=false

#================#
#== USER INPUT ==#
#================#
local _input=(${args[input]:-})
local _output=${args[output]}

#===============#
#== FUNCTIONS ==#
#===============#

_tif2pdf() {

for file in ${_input[@]}; do
  name=$(echo $file | cut -f 1 -d '.')
  echo "Converting TIF to PDF - $file to $name.pdf"

  if [[ -n $_output ]]; then
      pdfarray+=("$name.pdf")
      _flag_one_output=true
  fi
  magick $file -resize 100% -gravity center -extent %[fx:w]x%[fx:h] $name.pdf
done

if [[ $_flag_one_output == true ]]; then
    echo "Creating $_output.."
    pdftk ${pdfarray[@]} cat output $_output
    echo "Removing tmp files.."
    rm -f ${pdfarray[@]}
fi

}

#==================#
#== MAIN PROGRAM ==#
#==================#

## converting tif to pdf
_tif2pdf


