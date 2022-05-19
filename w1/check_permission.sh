#! /bin/bash

# kiem tra permission cua 1 file
# input: ten 1 file
# output: quyen cua file do

echo -n "Enter file name: "

read file
ls -la | grep $file

FILE="example.tar.gz"

echo "${FILE%%.*}"

echo "${FILE%.*}"

echo "${FILE#*.}"

echo "${FILE##*.}"