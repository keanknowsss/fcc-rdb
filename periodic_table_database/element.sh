PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c";


if [[ -z $1 ]]
then
  echo "Please provide an element as an argument.";
else 
  # Check if argument is number
  if [[ $1 =~ ^-?[0-9]+$ ]] 
  then
    ELEMENT=$($PSQL "SELECT * FROM elements WHERE atomic_number=$1");
  else
    ELEMENT=$($PSQL "SELECT * FROM elements WHERE symbol='$1' OR name='$1'");
  fi

  if [[ -z $ELEMENT ]]
  then
    echo "I could not find that element in the database.";
  else
    # Assign columns to variables
    IFS='|' read ATOMIC_NUMBER SYMBOL ELEMENT_NAME <<< $ELEMENT
    
    PROPERTIES=$($PSQL "SELECT type_id, atomic_mass, melting_point_celsius, boiling_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER");
    if [[ -z $PROPERTIES ]]
    then
      echo "I could not find that element in the database.";
    else
      IFS='|' read TYPE_ID ATOMIC_MASS MELTING_POINT BOILING_POINT <<< $PROPERTIES
      TYPE=$($PSQL "SELECT type FROM types WHERE type_id=$TYPE_ID");
      echo "The element with atomic number $ATOMIC_NUMBER is $ELEMENT_NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $ELEMENT_NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius.";
    fi
  fi
fi

