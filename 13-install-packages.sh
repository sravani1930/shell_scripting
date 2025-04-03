#!/bin/bash
ID=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S)
LOGFILE="/tmp/$0_$TIMESTAMP.log"

echo "script started executing at $TIMESTAMP" &>> $LOGFILE

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

validate(){
   if [ $1 -ne 0 ]
   then
      echo -e "$R ERROR :: $2 .. FAILED $N"
      exit 1;
   else
      echo -e "$G $2 ... SUCCESS $N"
   fi
}

if [ $ID -ne 0 ]
then
   echo -e "$R please switch to root user $N"
   exit 1
else
   echo "proceed to install the package"
fi

for package in $@
do
  yum list installed $package
  if [ $? -ne 0 ]
  then
      yum install $package &>> $LOGFILE
      validate $? "$package INSTALLATION"
   else
      echo -e "$Package is already Installed !!!.. $Y SKIPPING $N"
   fi
done