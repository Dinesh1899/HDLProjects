#!/bin/sh

file="tb_files.txt"

echo "Reading from $file ..."
cat "$file"
echo "------------------------"

while read -r line; do
    echo $line
done < "$file"

echo "Loop finished."
