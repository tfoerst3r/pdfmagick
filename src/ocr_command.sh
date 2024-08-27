#!/usr/bin/env bash
# SPDX-FileCopyrightText: Copyright (c) 2024 Thomas Förster
# SPDX-License-Identifier: MIT

#====================#
#== INITIALIZATION ==#
#====================#
_output_file=""

#================#
#== USER INPUT ==#
#================#
_language=${args[--lang]}
_input_file=${args[input]}

#===============#
#== FUNCTIONS ==#
#===============#

_set_output_file() {
## TODO further output option not set yet, there should be an option for 
_output_file=$_input_file
##  if [[ ! -f "$_output_file" ]] && [[ "$_output_file" == *.pdf ]]; then
##      echo "$_output_file is set as the output."
##  elif [ -f "$_output_file" ]; then
##      _die "Error. Output file exists. Choose a non existing file."
##  else
##      _output_file=$_input_file
##  fi
}  

_set_config() {

  #-- The else option will only occur when you do --lang ''
  if [ -n "$_language" ]; then
      _ocr_config="--output-type pdf \
          --language $_language \
          --redo-ocr"
  else
      _ocr_config="--output-type pdf \
          --redo-ocr"
  fi

  _ocr_config=$(echo "$_ocr_config" | sed 's/ \+/ /g')
}

#--------------#

_ocr() {

## Set output file
_set_output_file

## Set up the used tool configuration (ocrmypdf)
_set_config

## -- main routine -- ##
echo "Executing.. ocrmypdf $_ocr_config $_input_file --optimize 1 $_output_file"
ocrmypdf $_ocr_config $_input_file --optimize 1 $_output_file
echo "OCR of $_input_file is done. The new/overwritten file is $_output_file"

}

#==================#
#== MAIN PROGRAM ==#
#==================#
_ocr
