#!/bin/bash
# shellcheck disable=SC2162

#password generator script

echo "This is a simple password generator"
echo "Please enter the length of the password"

function passGenerator(){
read PASS_LENGTH
echo "How many passwords would you like to generate?"
read PASS_SEQ

echo "-----------------THE PASSWORDS-----------------------"
 for p in $(seq $PASS_SEQ);
do
  openssl rand -base64 48 | cut -c1-$PASS_LENGTH
done
echo "-----------------THE PASSWORDS-----------------------"
}

passGenerator
