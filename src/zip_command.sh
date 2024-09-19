#!/usr/bin/env bash
# SPDX-FileCopyrightText: Copyright (c) 2024 Thomas Förster
# SPDX-License-Identifier: MIT

#================#
#== USER INPUT ==#
#================#
FILE_ODD=${args[file_odd]}
FILE_EVEN=${args[file_even]}
OUTPUT=${args[output]}

#===============#
#== FUNCTIONS ==#
#===============#

_initialization(){
    
  _pages=()
  # Creating a tmp folder in /tmp
  _temp_dir=$(mktemp -d) 
  _num_pages1=$(pdftk $FILE_ODD dump_data | grep NumberOfPages | awk '{print $2}')
  local _num_pages2=$(pdftk $FILE_EVEN dump_data | grep NumberOfPages | awk '{print $2}')
  _diff_pages=$((num_pages1 - num_pages2))

}

#---------------#

_burst_pages(){

  ## Split the odd and even PDFs into individual pages
  pdftk "$FILE_ODD" burst output "$_temp_dir/odd_%04d.pdf"
  pdftk "$FILE_EVEN" burst output "$_temp_dir/even_%04d.pdf"

}

#---------------#

_merge_pages(){

  ## Initialize an empty array to hold the page files
  if (( $_diff_pages == 0 || $_diff_pages == 1 )); then
    for ((i=1; i<=_num_pages1; i++)); do
          
      _odd_page=$(printf "$_temp_dir/odd_%04d.pdf" "$i")
      _even_page=$(printf "$_temp_dir/even_%04d.pdf" "$i")
      _pages+=("$_odd_page" "$_even_page")
  
    done
  else 
      _msg "number of pages of the pdf's do not match"
  fi
  
  ## Merging pages
  pdftk "${_pages[@]}" cat output "$OUTPUT" 
  
  ## Output message
  _msg "Combined PDF created: $OUTPUT"

}

#---------------#

_cleanup(){
  ## Clean up the temporary directory including bursted files
  rm -rf "$_temp_dir" 
  ## Clean up the temporary file
  rm -f "tmp_$OUTPUT"
}

#==================#
#== MAIN PROGRAM ==#
#==================#
_initialization
_burst_pages
_merge_pages
