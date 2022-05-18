#! /bin/bash
# thay doi quyen cho file
# input: ten 1 file, quyen muon setup
# output: thay doi quyen cho file

check=1
echo -n "Filename(path to file): "
read filename
echo -n "Permission: "
read permission
chmod $permission $filename