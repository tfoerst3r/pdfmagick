# SPDX-FileCopyrightText: Copyright (c) 2024 Thomas Förster
# SPDX-License-Identifier: MIT

validate_pdf_in_name() {
  file="$1"
  file_extension=`echo ${file##*.} | tr '[:upper:]' '[:lower:]'`
  ( [[ "$file_extension" == 'pdf' ]] ) || echo "$file does not have the abbriviaton *.pdf"
}

