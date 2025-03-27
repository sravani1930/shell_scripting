#!/bin/bash

NUM1=$1
NUM2=$2

SUM=$(($NUM1+$NUM2))

echo "the sum of two numbers are :$SUM"

echo "No of  args passed are :: $#"

echo "args passed are :: $@"

echo "script name is :: $0"
