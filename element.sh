#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table --tuples-only -c"

if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
fi

# fail if anything other than spaces or numbers
# fail if reading ERROR or if response is blank

if [[ $1 =~ ^[0-9]+$ ]]; then
  echo "detected number"
elif [[ $1 =~ ^[A-Z]$|^[A-Z][a-z]$ ]]; then
  echo "detected symbol"
elif [[ $1 =~ ^[a-zA-Z]+$ ]]; then
  echo "detected name"
else
  echo "detected none"
fi