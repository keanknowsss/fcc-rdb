#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
while IFS=',' read year round winner opponent winner_goals opponent_goals
do
  if [[ $year != 'year' ]] 
  then
    # INSERTING WINNER
    winning_team=$($PSQL "SELECT team_id FROM teams WHERE name = '$winner'");

    if [[ -z $winning_team ]]
    then
      $PSQL "INSERT INTO teams(name) VALUES ('$winner')";
      winning_team=$($PSQL "SELECT team_id FROM teams WHERE name = '$winner'");
    fi

    # INSERTING OPPONENT
    opponent_team=$($PSQL "SELECT team_id FROM teams WHERE name = '$opponent'");

    if [[ -z $opponent_team ]]
    then
      $PSQL "INSERT INTO teams(name) VALUES ('$opponent')";
      opponent_team=$($PSQL "SELECT team_id FROM teams WHERE name = '$opponent'");
    fi

    $PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES ('$year', '$round', '$winning_team', '$opponent_team', '$winner_goals', '$opponent_goals')";
  fi
done < games.csv