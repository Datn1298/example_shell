#! /bin/bash

# kiem tra permission cua 1 file
# input: ten 1 file
# output: quyen cua file do

echo -e "Filename(path to file): "
read filename
ls -la | grep $filename