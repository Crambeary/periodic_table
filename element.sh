#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table --tuples-only -c"

PRINT_ELEMENT() {
  echo "$1 $2 $3 $4 $5 $6 $7 $8 $9 ${10} ${11} ${12} ${13}" | while read ATOM_NUM BAR ATOM_MASS BAR MP_C BAR BP_C BAR TYPE BAR SYMBOL BAR NAME
    do
      echo "The element with atomic number $ATOM_NUM is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOM_MASS amu. $NAME has a melting point of $MP_C celsius and a boiling point of $BP_C celsius."
    done
}

if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
elif [[ -z $QUERY_RESULT ]] && [[ -z $1 ]]; then
  echo "I could not find that element in the database."
else
  if [[ $1 =~ ^[0-9]+$ ]]; then
    QUERY_RESULT=$($PSQL "SELECT properties.atomic_number, properties.atomic_mass, properties.melting_point_celsius, properties.boiling_point_celsius, types.type, elements.symbol, elements.name FROM properties FULL JOIN elements ON properties.atomic_number = elements.atomic_number FULL JOIN types ON properties.type_id = types.type_id WHERE properties.atomic_number=$1")
    PRINT_ELEMENT $QUERY_RESULT
  elif [[ $1 =~ ^[A-Z]$|^[A-Z][a-z]$ ]]; then
    QUERY_RESULT=$($PSQL "SELECT properties.atomic_number, properties.atomic_mass, properties.melting_point_celsius, properties.boiling_point_celsius, types.type, elements.symbol, elements.name FROM properties FULL JOIN elements ON properties.atomic_number = elements.atomic_number FULL JOIN types ON properties.type_id = types.type_id WHERE elements.symbol='$1'")
    PRINT_ELEMENT $QUERY_RESULT
  elif [[ $1 =~ ^[a-zA-Z]+$ ]]; then
    QUERY_RESULT=$($PSQL "SELECT properties.atomic_number, properties.atomic_mass, properties.melting_point_celsius, properties.boiling_point_celsius, types.type, elements.symbol, elements.name FROM properties FULL JOIN elements ON properties.atomic_number = elements.atomic_number FULL JOIN types ON properties.type_id = types.type_id WHERE elements.name='$1'")
    if [[ ! -z $QUERY_RESULT ]]; then
      PRINT_ELEMENT $QUERY_RESULT
    else
      echo "I could not find that element in the database."
    fi
  fi
fi
