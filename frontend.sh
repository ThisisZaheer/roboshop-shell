echo -e "${color}Installing Nginx Server${nocolor}"
yum install nginx -y &>>/tmp/roboshop.log

echo -e "${color}Removing Default Content on Server${nocolor}"
rm -rf /usr/share/nginx/html/* &>>/tmp/roboshop.log

echo -e "${color}Downloading Frontend Content${nocolor}"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>/tmp/roboshop.log

echo -e "${color}Extracting the Frontend Content${nocolor}"
cd /usr/share/nginx/html &>>/tmp/roboshop.log
unzip /tmp/frontend.zip &>>/tmp/roboshop.log

echo -e "${color}Update Config Files${nocolor}"
cp /root/roboshop-shell/roboshop.conf /etc/nginx/default.d/roboshop.conf

echo -e "${color}Starting Nginx Server${nocolor}"
systemctl enable nginx &>>/tmp/roboshop.log
systemctl restart nginx &>>/tmp/roboshop.log