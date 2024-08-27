# SPDX-FileCopyrightText: Copyright (c) 2024 Thomas Förster
# SPDX-License-Identifier: MIT

validate_tif_exists() {
  file="$1"
  file_extension=`echo ${file##*.} | tr '[:upper:]' '[:lower:]'`
  ( [[ -f $file ]] && [[ "$file_extension" == 'tif' ]] ) || echo "$file must be an existing tif."
}
