#! /bin/bash

# kiem tra permission cua 1 file
# input: ten 1 file
# output: quyen cua file do

echo "===== CHECK PERMISSION OF FILE ====="
echo -n "Enter file name: "

read file
ls -la | grep $file

path=${file%/*}
name=${file##*/}

if [$path -eq $name]
then
  ls -la | grep $name
else
  temp=$PWD
  cd $path
  ls -la | grep $name
  cd $temp
fi