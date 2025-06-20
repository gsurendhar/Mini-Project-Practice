#!/bin/bash
#variables
START_TIME=$(date +%S)
USERID=$(id -u)
SCRIPT_DIR=$PWD
LOG_FOLDER="/var/log/expense-logs"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOG_FOLDER/$SCRIPT_NAME.log"
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"


echo "Script execution started at $(date)" | tee -a $LOG_FILE

mkdir -p $LOG_FOLDER

# ROOT PRIVILEGES CHECKING
if [ $USERID -ne 0 ]
then 
    echo -e "$R ERROR:$N Please run Script with the root access" | tee -a $LOG_FILE
    exit 1
else 
    echo -e "You are already running with $Y ROOT access $N" | tee -a $LOG_FILE
fi

# VALIDATION FUNCTION
VALIDATE(){
    if [ $1 -eq 0 ]
    then
        echo -e "$2 is ........$G SUCCESSES $N"  | tee -a $LOG_FILE
    else    
        echo -e "$2 is .........$R FAILURE $N"   | tee -a $LOG_FILE
        exit 1
    fi
}


# echo "Please enter MySql Root Password"  | tee -a $LOG_FILE
# read -s MYSQL_ROOT_PASSWORD

dnf install mysql-server -y &>>$LOG_FILE
VALIDATE $? "Installing MySql"


systemctl enable mysqld  &>>$LOG_FILE
VALIDATE $? "Enabling MySql Service"

systemctl start mysqld  &>>$LOG_FILE
VALIDATE $? "Starting MySql Service" 

mysql_secure_installation --set-root-pass ExpenseApp@1
VALIDATE $? "Setting MySql Root Password"

END_TIME=$(date +%S)
TOTAL_TIME=$(($END_TIME-$START_TIME))
echo -e "Script Execution Completed Successfully, $Y time taken : $TOTAL_TIME Seconds $N "
