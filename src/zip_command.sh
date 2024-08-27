#!/usr/bin/env bash
# SPDX-FileCopyrightText: Copyright (c) 2024 Thomas Förster
# SPDX-License-Identifier: MIT

#====================#
#== INITIALIZATION ==#
#====================#

DPI=${args[--density]}
FILE_ODD=${args[file_odd]}
FILE_EVEN=${args[file_even]}
OUTPUT=${args[output]}

#===============#
#== FUNCTIONS ==#
#===============#

_merge(){

# Check if a merge is possible
num_pages1=$(pdftk $FILE_ODD dump_data | grep NumberOfPages | awk '{print $2}')
num_pages2=$(pdftk $FILE_EVEN dump_data | grep NumberOfPages | awk '{print $2}')
diff=$((num_pages1 - num_pages2))

# Create Temp folder in /tmp
temp_dir=$(mktemp -d)

# Split the odd and even PDFs into individual pages
pdftk "$FILE_ODD" burst output "$temp_dir/odd_%04d.pdf"
pdftk "$FILE_EVEN" burst output "$temp_dir/even_%04d.pdf"

# Initialize an empty array to hold the page files
pages=()

num_pages1=$(pdftk $FILE_ODD dump_data | grep NumberOfPages | awk '{print $2}')

if (( $diff == 0 || $diff == 1 )); then
    for ((i=1; i<=num_pages1; i++)); do
        
        odd_page=$(printf "$temp_dir/odd_%04d.pdf" "$i")
        even_page=$(printf "$temp_dir/even_%04d.pdf" "$i")
        pages+=("$odd_page" "$even_page")
    
    done
else 
    msg "number of pages of the pdf's do not match"
fi

echo $pages

pdftk "${pages[@]}" cat output "tmp_$OUTPUT" 

magick -density $DPI "tmp_$OUTPUT" -compress Zip $OUTPUT



# Clean up the temporary directory
rm -rf "$temp_dir" "tmp_$OUTPUT"

echo "Combined PDF created: $OUTPUT"

}

#==================#
#== MAIN PROGRAM ==#
#==================#
_merge
