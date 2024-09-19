# SPDX-FileCopyrightText: Copyright (c) 2024 Thomas Förster
# SPDX-License-Identifier: MIT

validate_filecheck() {
  ## == USER INPUT == ##
  local files=(${args[file]:-})
  ##echo ${files[1]}  
  ## == VARIABLES == ##
  
  ## == MAIN == ##
    
  ##-- Part1: extration what the use want to do, ex. tif2pdf, ...
  local func_call=${FUNCNAME[1]}
  local global_script=`basename $0`
  
  ## Subfunction call name
  [[ ${func_call} =~ ^${global_script}_([[:alnum:]]+)_parse_requirements$ ]]
  local func_name=${BASH_REMATCH[1]}
  
  ## Check for the extenion to convert from
  [[ ${func_name} =~ ^([[:alnum:]]+)2[[:alnum:]]+$ ]]

  local extension=${BASH_REMATCH[1]}
  ##--

  for file in ${files[@]}; do
    local file_extension=`echo ${file##*.} | tr '[:upper:]' '[:lower:]'`
    ## check existens of the file 
    if [[ ! -f "$file" ]]; then
        echo "$file does not exist."
    fi
    
    ## check if extension mets the function call
    if [[ $file_extension != $extension ]]; then
      echo "$file must be of type $extension and not $file_extension."
    fi
  done
 
}

