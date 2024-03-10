#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
  
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

$PSQL "
INSERT INTO teams (name) VALUES
('France'),
('Belgium'),
('Croatia'),
('England'),
('Sweden'),
('Brazil'),
('Russia'),
('Uruguay'),
('Germany'),
('Netherlands'),
('Argentina'),
('Colombia'),
('Costa Rica'),
('Switzerland'),
('Japan'),
('Mexico'),
('Denmark'),
('Spain'),
('Portugal'),
('Chile'), 
('Nigeria'),
('Algeria'),
('Greece'),
('United States');"

# read from the CSV file, skip the header
tail -n +2 games.csv | while IFS="," read year round winner opponent winner_goals opponent_goals
do
  # get winner_id
  winner_id=$($PSQL "SELECT team_id FROM teams WHERE name='$winner'")
  # get opponent_id
  opponent_id=$($PSQL "SELECT team_id FROM teams WHERE name='$opponent'")
  
  # insert game record into database
  $PSQL "INSERT INTO games (year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES
  ($year, '$round', $winner_id, $opponent_id, $winner_goals, $opponent_goals)"
done