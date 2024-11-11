#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table --tuples-only -c"

if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
elif [[ -z $QUERY_RESULT ]] && [[ -z $1 ]]; then
  echo "I could not find that element in the database."
else
  if [[ $1 =~ ^[0-9]+$ ]]; then
    QUERY_RESULT=$($PSQL "SELECT * FROM properties FULL JOIN elements ON properties.atomic_number = elements.atomic_number FULL JOIN types ON properties.type_id = types.type_id WHERE properties.atomic_number=$1")
    echo $QUERY_RESULT
  elif [[ $1 =~ ^[A-Z]$|^[A-Z][a-z]$ ]]; then
    QUERY_RESULT=$($PSQL "SELECT * FROM properties FULL JOIN elements ON properties.atomic_number = elements.atomic_number FULL JOIN types ON properties.type_id = types.type_id WHERE elements.symbol='$1'")
    echo $QUERY_RESULT
  elif [[ $1 =~ ^[a-zA-Z]+$ ]]; then
    QUERY_RESULT=$($PSQL "SELECT * FROM properties FULL JOIN elements ON properties.atomic_number = elements.atomic_number FULL JOIN types ON properties.type_id = types.type_id WHERE elements.name='$1'")
    if [[ ! -z $QUERY_RESULT ]]; then
      echo $QUERY_RESULT
    else
      echo "I could not find that element in the database."
    fi
  fi
fi
