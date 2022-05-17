#! /bin/bash

# thay doi quyen cho file
# input: ten 1 file, quyen muon setup
# output: thay doi quyen cho file

echo -e "Filename(path to file): "
read filename
echo -e "Permission: "
read permission
chmod $permission $filename