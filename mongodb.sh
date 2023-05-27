echo -e "\e[36mCopy Repo file\e[0m"
cp mongodb.repo /etc/yum.repos.d/mongo.repo &>>/tmp/roboshop.log

echo -e "\e[36mInstalling MongoDB Server\e[0m"
yum install mongodb-org -y &>>/tmp/roboshop.log

#create local host

echo -e "\e[36mStart MongoDB\e[0m"
systemctl enable mongod  &>>/tmp/roboshop.log
systemctl restart mongod &>>/tmp/roboshop.log