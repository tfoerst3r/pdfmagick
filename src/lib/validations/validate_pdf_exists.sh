# SPDX-FileCopyrightText: Copyright (c) 2024 Thomas Förster
# SPDX-License-Identifier: MIT

validate_pdf_exists() {
  file="$1"
  extension="pdf"
  file_extension=`echo ${file##*.} | tr '[:upper:]' '[:lower:]'`

  if [[ ! -f $file ]] && [[ $file_extension != $extension ]]; then
      echo "$file must be an existing $extension."
  fi
}
