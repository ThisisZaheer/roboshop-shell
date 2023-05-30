component=catalogue
color="\e[33m"
nocolor="\e[0m"

echo -e "${color}Configuration files ${nocolor}"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/roboshop.log

echo -e "${color}Installing NodeJS ${nocolor}"
yum install nodejs -y &>>/tmp/roboshop.log

echo -e "${color}Adding User ${nocolor}"
useradd roboshop &>>/tmp/roboshop.log

echo -e "${color}Removing default content ${nocolor}"
rm -rf /app &>>/tmp/roboshop.log
mkdir /app

echo -e "${color}Downloading the $component content ${nocolor}"
curl -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component.zip &>>/tmp/roboshop.log
cd /app

echo -e "${color}Extract the $component content ${nocolor}"
unzip /tmp/$component.zip &>>/tmp/roboshop.log
cd /app

echo -e "${color}Installing NodeJS Depenencies ${nocolor}"
npm install &>>/tmp/roboshop.log

echo -e "${color}Copy Service files ${nocolor}"
cp /root/roboshop-shell/$component.service /etc/systemd/system/$component.service

echo -e "${color}Reload files ${nocolor}"
systemctl daemon-reload &>>/tmp/roboshop.log

echo -e "${color}Start the $component Server ${nocolor}"
systemctl enable $component &>>/tmp/roboshop.log
systemctl restart $component &>>/tmp/roboshop.log

echo -e "${color}Copy the MongoDB Repo Service ${nocolor}"
cp /root/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongo.repo

echo -e "${color}Install Mongodb Server ${nocolor}"
yum install mongodb-org-shell -y &>>/tmp/roboshop.log

echo -e "${color}Schema files load ${nocolor}"
mongo --host mongodb-dev.thisiszaheer.online </app/schema/$component.js &>>/tmp/roboshop.log