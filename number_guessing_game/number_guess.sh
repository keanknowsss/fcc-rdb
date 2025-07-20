#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

RANDOM_NUMBER=$((1 + $RANDOM % 1000))

echo "Enter your username:";
read USERNAME;

# CHECK USERNAME LENGTH
while true;
do
  if [[ ${#USERNAME} -gt 22 ]]
  then
    echo -e "\nUsername must be 22 characters or less. Please try again";
    read USERNAME;
  else
    break;
  fi
done

# GET USER
USER=$($PSQL "SELECT username FROM users WHERE username='$USERNAME'");
if [[ -z $USER ]]
then
  # CREATE NEW USER
  CREATE_USER=$($PSQL "INSERT INTO users(username) VALUES ('$USERNAME')");
  USER=$($PSQL "SELECT * FROM users WHERE username='$USERNAME'");
  IFS='|' read USER_ID USERNAME GAMES_PLAYED BEST_GAME <<< $USER;

  # WELCOME
  echo -e "\nWelcome, $USERNAME! It looks like this is your first time here.";
else 
  USER=$($PSQL "SELECT * FROM users WHERE username='$USERNAME'");
  IFS='|' read USER_ID USERNAME GAMES_PLAYED BEST_GAME <<< $USER;

  # WELCOME
  if [[ -z $BEST_GAME ]]
  then
    echo -e "\nWelcome back, $USERNAME! You have played $GAMES_PLAYED games."
  else
    echo -e "\nWelcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
  fi
fi



echo -e "\nGuess the secret number between 1 and 1000:"
echo "ANSWER: $RANDOM_NUMBER"

ATTEMPTS=0
while true;
do
  read GUESS;

  # CHECK IF NOT NUMBER
  if ! [[ $GUESS =~ ^-?[0-9]+$ ]] 
  then
    echo -e "\nThat is not an integer, guess again:"
    continue;
  fi 

  ATTEMPTS=$(( ATTEMPTS + 1 ))
  if [[ $GUESS -eq $RANDOM_NUMBER ]]
  then
    # CORRECT
    break;
  elif [[ $GUESS -lt $RANDOM_NUMBER ]]
  then
    # LOWER
    echo -e "\nIt's higher than that, guess again:"
    continue;
  elif [[ $GUESS -gt $RANDOM_NUMBER ]]
  then
    # GREATER
    echo -e "\nIt's lower than that, guess again:"
    continue;
  fi
done


# UPDATE_BEST_GAME
if [[ -z $BEST_GAME ]]
then
  UPDATE_BEST_GAME=$($PSQL "UPDATE users SET best_game=$ATTEMPTS WHERE username='$USERNAME'");
else
  # COMPARE BEST_GAME AND ATTEMPTS
  if [[ $ATTEMPTS -lt $BEST_GAME ]]
  then
    UPDATE_BEST_GAME=$($PSQL "UPDATE users SET best_game=$ATTEMPTS WHERE username='$USERNAME'");
  fi
fi

# UPDATE GAMES COUNTER
NEW_GAMES_PLAYED=$(( $GAMES_PLAYED + 1 ))
UPDATE_GAMES=$($PSQL "UPDATE users SET games_played = $NEW_GAMES_PLAYED WHERE username = '$USERNAME'");

echo "You guessed it in $ATTEMPTS tries. The secret number was $RANDOM_NUMBER. Nice job!";