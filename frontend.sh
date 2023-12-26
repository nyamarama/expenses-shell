log_file=/tmp/expense.log
color="\e[32m"

status_check() {
  if [ $? -eq 0 ]; then
    echo success
  else
    echo failure
  fi
}


echo -e "${color} installing nginx \e[0m"
dnf install nginx -y &>>$log_file
status_check

echo -e "${color} copy the configuration file \e[0m"
cp expense.conf /etc/nginx/default.d/expense.conf &>>$log_file
status_check

echo -e "${color} remove the default content \e[0m"
rm -rf /usr/share/nginx/html/* &>>$log_file
status_check

echo -e "${color} download the frontend content \e[0m"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip &>>$log_file
status_check

echo -e "${color} change directory and unzip the content \e[0m"
cd /usr/share/nginx/html &>>$log_file
unzip /tmp/frontend.zip &>>$log_file
status_check

echo -e "${color} enable and restart nginx \e[0m"
systemctl enable nginx &>>$log_file
systemctl restart nginx &>>$log_file
status_check


