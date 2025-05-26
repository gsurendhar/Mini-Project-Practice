#!/bin/bash
#variables
START_TIME=$(date +%S)
USERID=$(id -u)
SCRIPT_DIR=$PWD
LOG_FOLDER="/var/log/expense-logs"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOG_FOLDER/$SCRIPT_NAME.log"
R="\e[31"
G="\e[31"
Y="\e[31"
N="\e[31"

echo "Script execution started at $START_TIME " | tee -a $LOG_FILE

mkdir -p $LOG_FOLDER

# ROOT PRIVILEGES CHECKING
if [ $USERID -ne 0 ]
then 
    echo -e " $R ERROR:$N Please run Script with the root access " | tee -a $LOG_FILE
    exit 1
else 
    echo -e " You are already running with $Y ROOT $N access " | tee -a $LOG_FILE
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

dnf module disable nodejs -y  &>>$LOG_FILE
VALIDATE $? "Disabling Default nodejs"

dnf module enable nodejs:20 -y &>>$LOG_FILE
VALIDATE $? "enabling Default nodejs"

dnf install nodejs -y &>>$LOG_FILE
VALIDATE $? "Installing nodejs:20 "

id roboshop
if [ $? -ne 0 ]
then
    useradd --system --home /app --shell /sbin/nologin --comment "Roboshop system user " roboshop 
    VALIDATE $? "Roboshop system user creating" 
else
    echo -e "roboshop user is already Created ....$Y SKIPPING USER Creation $N"
fi

mkdir -p /opt/app
VALIDATE $? "Creating App directory"

curl -o /tmp/backend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-backend-v2.zip  &>>$LOG_FILE
VALIDATE $? "Downloading backend"

cd /opt/app 
rm -rf /opt/app/*
unzip /tmp/backend.zip &>>$LOG_FILE
VALIDATE $? "Unzipping backend"

npm install &>>$LOG_FILE
VALIDATE $? "Installing Dependencies"

cp $SCRIPT_DIR/backend.service /etc/systemd/system/backend.service &>>$LOG_FILE
VALIDATE $? "backend service file is copied "

systemctl daemon-reload &>>$LOG_FILE
VALIDATE $? "Daemon Reloading"

systemctl enable backend &>>$LOG_FILE
VALIDATE $? "backend is enabling"

systemctl start backend &>>$LOG_FILE
VALIDATE $? "Staring the backend service"

dnf install mysql -y &>>$LOG_FILE
VALIDATE $? "Installing MySql Client"

mysql -h mysql.gonela.site -uroot -pExpenseApp@1 < /opt/app/schema/backend.sql
VALIDATE $? "Loading SCHEMAS to MySQL"

systemctl restart backend  &>>$LOG_FILE
VALIDATE $? "Restarting Backend Services" 


END_TIME=$(date +%S)
TOTAL_TIME=$(($END_TIME-$START_TIME))
echo -e "Script Execution Completed Successfully, $Y time taken : $TOTAL_TIME Seconds $N "