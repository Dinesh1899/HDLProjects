#!/bin/sh

file="tb_files.txt"

echo "Reading from $file ..."
cat "$file"
echo "------------------------"

while read -r line; do
    # Reading each line
    echo "Using directory : $line"
    echo "Compiling sources"
done < "$file"

echo "Loop finished."