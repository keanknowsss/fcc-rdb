#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=salon -t --no-align -c"

MAIN_MENU () {
  echo -e "\n~~~~~ MY SALON ~~~~~\n"

  SERVICES=$($PSQL "SELECT * FROM services ORDER BY service_id");
  echo -e "$SERVICES" | sed 's/|/) /';
}
MAIN_MENU;

read SERVICE_ID_SELECTED;
SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id='$SERVICE_ID_SELECTED'");

if [[ -z $SERVICE_NAME ]] 
then
  # show menu
  MAIN_MENU
else
  # get customer number
  echo -e "\nPlease enter your phone number:"
  read CUSTOMER_PHONE

  CUSTOMER=$($PSQL "SELECT customer_id, name FROM customers WHERE phone='$CUSTOMER_PHONE'");
  IFS='|' read CUSTOMER_ID CUSTOMER_NAME <<< "$CUSTOMER"

  # check if customer is existing using phone
  if [[ -z $CUSTOMER ]]
  then
    echo -e "\nPlease enter your name"
    read CUSTOMER_NAME

    # create user
    INSERT_TO_CUSTOMER=$($PSQL "INSERT INTO customers(name, phone) VALUES('$CUSTOMER_NAME', '$CUSTOMER_PHONE')");
    CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'");
  fi

  echo -e "\nPlease enter the time for your appointment (24hr-format):"
  read SERVICE_TIME

  INSERT_APPOINTMENT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES ($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')");
  
  echo -e "\nI have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
fi