component=catalogue


echo -e "\e[32mConfiguration files\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/roboshop.log

echo -e "\e[32mInstalling NodeJS\e[0m"
yum install nodejs -y &>>/tmp/roboshop.log

echo -e "\e[32mAdding User\e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[32mRemoving default content\e[0m"
rm -rf /app &>>/tmp/roboshop.log
mkdir /app

echo -e "\e[32mDownloading the $component content"
curl -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component.zip &>>/tmp/roboshop.log
cd /app

echo -e "\e[36mExtract the $component content\e[0m"
unzip /tmp/$component.zip &>>/tmp/roboshop.log
cd /app

echo -e "\e[32mInstalling NodeJS Depenencies\e[0m"
npm install &>>/tmp/roboshop.log

echo -e "\e[32mCopy Service files\e[0m"
cp /root/roboshop-shell/$component.service /etc/systemd/system/$component.service

echo -e "\e[32mReload files\e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log

echo -e "\e[32mStart the $component Server\e[0m"
systemctl enable $component &>>/tmp/roboshop.log
systemctl restart $component &>>/tmp/roboshop.log

echo -e "\e[32mCopy the MongoDB Repo Service\e[0m"
cp /root/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongo.repo

echo -e "\e[32mInstall Mongodb Server\e[0m"
yum install mongodb-org-shell -y &>>/tmp/roboshop.log

echo -e "\e[32mSchema files load\e[0m"
mongo --host mongodb-dev.thisiszaheer.online </app/schema/$component.js &>>/tmp/roboshop.log