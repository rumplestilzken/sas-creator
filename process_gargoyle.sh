#!/bin/bash

if [ -f "$1" ];then
    srcFile="$1"
else
  echo "'$1' not a valid .img file."
  exit
fi

echo "Starting vnkdlite process."
sudo bash ./lite-adapter.sh 64 $srcFile

base_name="$(basename -- "$srcFile")"
new_base_name=${base_name%.*}
extension=${base_name##*.}
new_name="$new_base_name-vndklite.$extension"

echo "Renaming ''$base_name' to '$new_name' "

if [ -f s.img]; then
  mv s.img $new_base_name
else
  echo "Renaming failed."
fi

echo "Archiving '$new_name'"
tar -czvf "$new_base_name.tar.gz"
