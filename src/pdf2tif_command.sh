#!/usr/bin/env bash
# SPDX-FileCopyrightText: Copyright (c) 2024 Thomas Förster
# SPDX-License-Identifier: MIT

#====================#
#== INITIALIZATION ==#
#====================#
local _tifarray=()

#================#
#== USER INPUT ==#
#================#
local INPUT=(${args[input]:-})
local MERGETO=${args[--mergeto]}
local DPI=${args[--density]}

#===============#
#== FUNCTIONS ==#
#===============#
_set_magick_config() {
_magick_config="\
-quality 90 \
-background white \
-alpha background \
-compress zip"
}


#--------------#

_pdf2tif() {
  
  # Setting up config
  _set_magick_config
  
  for file in ${INPUT[@]}; do
    
    output="$(echo $file | cut -f 1 -d '.').tif"
    echo "Converting PDF to TIF - $file to $output"
    echo "Runnig ..."

    magick -density $DPI $file $_magick_config $output
    _tifarray+=("$output")

  done
}

#--------------#

_merge() {
  # merges all the *.tif files 
  # Setting up config
  _set_magick_config
    
  echo "Input will be accumulated in $MERGETO" 
  echo "Runnig ..."
  magick -density $DPI ${_tifarray[@]} $_magick_config -append $MERGETO

}


#==================#
#== MAIN PROGRAM ==#
#==================#
_pdf2tif

## merge the input to one file
if [[ -n $MERGETO ]]; then
  _merge
fi

