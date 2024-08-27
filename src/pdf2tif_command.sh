#!/usr/bin/env bash
# SPDX-FileCopyrightText: Copyright (c) 2024 Thomas Förster
# SPDX-License-Identifier: MIT

#====================#
#== INITIALIZATION ==#
#====================#
local tifarray=()

#================#
#== USER INPUT ==#
#================#
local files=(${args[file]:-})
local mergeto=${args[--mergeto]}
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
  _set_magick_config
  for file in ${files[@]}; do
    name="$(echo $file | cut -f 1 -d '.').tif"
    echo "Converting PDF to TIF - $file to $name"
    magick -density $DPI $file $_magick_config $name
    tifarray+=("$name")
  done
}

#--------------#

_merge() {
  ## Not sufficient 
  _set_magick_config
  echo "Input will be accumulated in $mergeto" 
  magick -density $DPI ${tifarray[@]} $_magick_config -append $mergeto
}

#==================#
#== MAIN PROGRAM ==#
#==================#
_pdf2tif

## merge the input to one file
if [[ -n $mergeto ]]; then
    _merge
fi

