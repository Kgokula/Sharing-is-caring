#!/usr/bin/ksh

# encrypt_string.ksh
#
#
# Change record:
# Author Date Comments
# Gokula Kandaswamy 09/23/2010 Created V1
# **************************************************************************************
# Purpose: This script applies a simple encryption to a string. It has the capability to also decrypt the same string
# 
# # Command line parameters to be passed
# first: The string which has to be encrypted or decrypted
# second: The action needed on the string i.e. whether it should encrypted or decrypted. 
# Valid values="encrypt" for Encryption and "decrypt" for decryption
# **************************************************************************************
# Usage for encryption: ./encrypt_string.ksh encrypt
# Usage for decryption: ./encrypt_string.ksh '' decrypt

MyString=$1
Type=$2

StrChange=''
i=1
k=1

while (( i <= ${#MyString} ))
do

[[ $k -eq 4 ]] && k=1

char=$(expr substr "$MyString" $i 1)
chr=`echo -n $char | od -A n -t u1`
chr=`echo $chr | sed 's/^0//'`
if [ $Type = "encrypt" ] && [ $chr -ne 126 ]
then
(( chr += $k ))
elif [ $Type = "decrypt" ] && [ $chr -ne 126 ]
then
(( chr -= $k ))
fi 
var=`awk -v char=$chr 'BEGIN { printf "%c\n", char; exit }'`
StrChange=`echo "$StrChange$var"`

(( i += 1 ))
(( k += 1 ))
done

echo $StrChange

# End of Script
