#!/bin/bash
#variables
START_SCRIPT=$(date +%S)
USERID=$(id -u)
SCRIPT_DIR=$PWD
LOG_FOLDER="/var/log/expense-logs"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOG_FOLDER/$SCRIPT_NAME.log"
R="\e[31"
G="\e[31"
Y="\e[31"
N="\e[31"

echo "Script execution started at $(date) " | tee -a $LOG_FILE

mkdir -p $LOG_FOLDER

# ROOT PRIVILEGES CHECKING
if [ $USERID -ne 0 ]
then 
    echo  "ERROR Please run Script with the root access " | tee -a $LOG_FILE
    exit 1
else 
    echo -e "You are already running with  ROOT access " | tee -a $LOG_FILE
fi

# VALIDATION FUNCTION
VALIDATE(){
    if [ $1 -eq 0 ]
    then
        echo -e "$2 is ........ SUCCESSES "  | tee -a $LOG_FILE
    else    
        echo -e "$2 is ......... FAILURE "   | tee -a $LOG_FILE
        exit 1
    fi
}

dnf module disable nginx -y &>>$LOG_FILE
VALIDATE $? "Disabling Default nginx "

dnf module enable nginx:1.24 -y &>>$LOG_FILE
VALIDATE $? "Enabling Nginx:1.24 "

dnf install nginx -y &>>$LOG_FILE
VALIDATE $? "Installing Nginx:1.24"

systemctl enable nginx &>>$LOG_FILE
VALIDATE $? "Enabling Nginx service"

systemctl start nginx &>>$LOG_FILE
VALIDATE $? "Starting Nginx"

rm -rf /usr/share/nginx/html/* &>>$LOG_FILE
VALIDATE $? "Removing Default Content"

curl -o /tmp/frontend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-frontend-v2.zip &>>$LOG_FILE
VALIDATE $? "Downloading Frontend"

cd /usr/share/nginx/html 
unzip /tmp/frontend.zip &>>$LOG_FILE
VALIDATE $? "Unzipping Frontend"

# rm -rf /etc/nginx/nginx.conf &>>$LOG_FILE
# VALIDATE $? "Removing Default nginx conf file"

cp $SCRIPT_DIR/expense.conf /etc/nginx/default.d/expense.conf &>>$LOG_FILE
VALIDATE $? "Adding nginx conf file"

systemctl restart nginx &>>$LOG_FILE
VALIDATE $? "Restarting Nginx"

END_TIME=$(date +%S)
TOTAL_TIME=$(($END_TIME-$START_SCRIPT))
echo -e "Script Execution Completed Successfully, $Y time taken : $TOTAL_TIME Seconds $N "