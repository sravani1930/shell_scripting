#!/bin/bash
ID=$(id -u)

if [ $ID -ne 0 ]
then
   echo " please switch to root user"
   exit 1
else
   echo "proceed to install the package"
fi

echo "All are=guments passed :$@"
