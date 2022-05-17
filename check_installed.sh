#!/bin/bash

dpkg -s $1 &> /dev/null

return $?
# if [ $? -eq 0 ]; then
#     echo "Package $1 is installed!"
# else
#     echo "Package $1 is NOT installed!"
# fi