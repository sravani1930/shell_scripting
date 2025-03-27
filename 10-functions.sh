#!/bin/bash
ID=$(id -u)
VALIDATE(){
   if [ $? -ne 0 ]
   then
   echo " ERROR :: MY SQL ISTALLATION FIALED"
   exit 1
else
   echo " MY SQL ISTALLATION SUCCESS"
fi
}

if [ $ID -ne 0 ]
then
   echo " please switch to root user"
   exit 1
else
   echo "proceed to install the package"
fi

yum install mysql -y


