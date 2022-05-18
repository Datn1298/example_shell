#! /bin/bash

# kiem tra permission cua 1 file
# input: ten 1 file
# output: quyen cua file do

echo -n "Enter file name : "

read file
# ls -la | grep $file
# find out if file has write permission or not
[ -w $file ] && W="Write = yes" || W="Write = No"
 
# find out if file has excute permission or not
[ -x $file ] && X="Execute = yes" || X="Execute = No"
 
# find out if file has read permission or not
[ -r $file ] && R="Read = yes" || R="Read = No"
 
echo "$file permissions"
echo "$W"
echo "$R"
echo "$X"