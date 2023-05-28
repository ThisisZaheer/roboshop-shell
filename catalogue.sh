echo -e "\e[32mConfiguration files\e[om"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/roboshop.log
echo -e "\e[32mInstalling NodeJS\e[om"
yum install nodejs -y &>>/tmp/roboshop.log
echo -e "\e[32mAdding User\e[om"
useradd roboshop &>>/tmp/roboshop.log
echo -e "\e[32mRemoving default content\e[0m"
rm -rf /app &>>/tmp/roboshop.log
mkdir /app
echo -e "\e[32mDownloading the catalogue content"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>/tmp/roboshop.log
cd /app
echo -e "\e[Extract the catalogue content\e[om"
unzip /tmp/catalogue.zip &>>/tmp/roboshop.log
cd /app
echo -e "\e[32mInstalling NodeJS Depenencies\e[om"
npm install &>>/tmp/roboshop.log
echo -e "\e[32mCopy Service files\e[om"
cp catalogue.service /etc/systemd/system/catalogue.service &>>/tmp/roboshop.log
#/etc/systemd/system/catalogue.service
echo -e "\e[32mRelaod files\e[om"
systemctl daemon-reload &>>/tmp/roboshop.log
echo -e "\e[32mStart the Server\e[om"
systemctl enable catalogue &>>/tmp/roboshop.log
systemctl restart catalogue &>>/tmp/roboshop.log
echo -e "\e[32mCopy the MongoDB Repo Service\e[om"
cp mongodb.repo /etc/yum.repos.d/mongo.repo &>>/tmp/roboshop.log
#/etc/yum.repos.d/mongo.repo
echo -e "\e[32mInstall Mongodb Server\e[om"
yum install mongodb-org-shell -y &>>/tmp/roboshop.log
echo -e "\e[32mSchema files load\e[om"
mongo --host mongodb-dev.thisiszaheer.online </app/schema/catalogue.js &>>/tmp/roboshop.log