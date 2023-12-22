echo -e "\e[32m installing nginx \e[0m"
dnf install nginx -y

echo -e "\e[34m copy the configuration file \e[0m"
cp expense.conf /etc/nginx/default.d/expense.conf

echo -e "\e[32m remove the default content \e[0m"
rm -rf /usr/share/nginx/html/*

echo -e "\e[34m download the frontend content \e[0m"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip

echo -e "\e[32m change directory and unzip the content \e[0m"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip

echo -e "\e[34m enable and restart nginx \e[0m"
systemctl enable nginx
systemctl restart nginx


