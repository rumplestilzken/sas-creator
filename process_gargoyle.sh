#!/bin/bash

if [ -f "$1" ];then
    srcFile="$1"
else
  echo "'$1' not a valid .img file."
  exit
fi

echo "Starting vnkdlite process."
sudo bash ./lite-adapter.sh 64 $srcFile

base_name="$(basename -- "$srcFile")" #Full File Name
new_base_name=${base_name%.*} #No extentsion
base_path=${srcFile%$base_name} #Original Path
extension=${base_name##*.} #Extension
new_name="$new_base_name-vndklite.$extension"

if [ -f s.img ]; then
  echo "Renaming 's.img' to '$new_name' "
  mv s.img $new_name
else
  echo "s.img not found."
  exit
fi

archive_name="$new_name.tar.gz"
echo "Archiving '$new_name' to '$archive_name'"
tar -czvf "$archive_name" "$new_name"

echo "Moving '$archive_name' to '$base_path$new_name'"
if [ -f $archive_name ]; then
  mv $archive_name "$base_path$archive_name"
  sudo rm $new_name
else
  echo "An error occured in moving the file"
fi

echo "Process Complete."
