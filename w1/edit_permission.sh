#! /bin/bash
# thay doi quyen cho file
# input: ten 1 file, quyen muon setup
# output: thay doi quyen cho file

echo -n "Enter file name: "
read filename
echo -n "Permission: "
read permission
chmod $permission $filename