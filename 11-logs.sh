#!/bin/bash
ID=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S)
LOGFILE="/tmp/$0_$TIMESTAMP.log"

echo "script started executing at $TIMESTAMP" &>> $LOGFILE

R="\e[31m"
G="\e[32m"
y="\e[33m"
N="\e[0m"

VALIDATE(){
   if [ $1 -ne 0 ]
   then
       echo -e " $R ERROR :: $2 ... FIALED !!!! $N"
       exit 1
   else
       echo  -e" $2 ....$G SUCCESS !!! $N"
   fi
}

if [ $ID -ne 0 ]
then
   echo  -e " $R please switch to root user $N"
   exit 1
else
   echo "proceed to install the package"
fi

yum install mysql -y &>> $LOGFILE

VALIDATE $? "MY SQL INSTALLATION "

yum install git -y &>> $LOGFILE

VALIDATE $? "GIT INSTALLATION"



