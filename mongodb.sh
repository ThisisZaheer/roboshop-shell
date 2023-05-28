echo -e "\e[36mCopy Repo file\e[0m"
cp /root/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongo.repo &>>/tmp/roboshop.log

echo -e "\e[36mInstalling MongoDB Server\e[0m"
yum install mongodb-org -y &>>/tmp/roboshop.log

echo -e "\e[33mUpdate IP Address\e[0m"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf

echo -e "\e[36mStart MongoDB\e[0m"
systemctl enable mongod  &>>/tmp/roboshop.log
systemctl restart mongod &>>/tmp/roboshop.log