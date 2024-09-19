# SPDX-FileCopyrightText: Copyright (c) 2024 Thomas Förster
# SPDX-License-Identifier: MIT

validate_tif_exists() {
  file="$1"
  extension="tif"
  file_extension=`echo ${file##*.} | tr '[:upper:]' '[:lower:]'`

  if [[ ! -f $file ]] && [[ $file_extension != $extension ]]; then
      echo "$file must be an existing $extension."
  fi
}
