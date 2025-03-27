#!/bin/bash
ID=$(id -u)

VALIDATE(){
   if [ $1 -ne 0 ]
   then
       echo " ERROR :: $2 ... FIALED !!!!"
       exit 1
   else
       echo " $2 SUCCESS !!!"
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

VALIDATE $? "MY SQL INSTALLATION "

yum install git -y

VALIDATE $? "GIT INSTALLATION"



