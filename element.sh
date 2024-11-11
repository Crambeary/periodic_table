#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table --tuples-only -c"

if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
fi

# fail if anything other than spaces or numbers
# fail if reading ERROR or if response is blank

if [[ $1 =~ ^[0-9]+$ ]]; then
  echo $($PSQL "SELECT * FROM properties FULL JOIN elements ON properties.atomic_number = elements.atomic_number FULL JOIN types ON properties.type_id = types.type_id WHERE properties.atomic_number=$1")
elif [[ $1 =~ ^[A-Z]$|^[A-Z][a-z]$ ]]; then
  echo $($PSQL "SELECT * FROM properties FULL JOIN elements ON properties.atomic_number = elements.atomic_number FULL JOIN types ON properties.type_id = types.type_id WHERE elements.symbol='$1'")
elif [[ $1 =~ ^[a-zA-Z]+$ ]]; the
  echo $($PSQL "SELECT * FROM properties FULL JOIN elements ON properties.atomic_number = elements.atomic_number FULL JOIN types ON properties.type_id = types.type_id WHERE elements.name='$1'")
else
  echo "I could not find that element in the database."
fi