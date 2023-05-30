component=catalogue


echo -e "${color}Configuration files ${nocolor}"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log_file}

echo -e "${color}Installing NodeJS ${nocolor}"
yum install nodejs -y &>>${log_file}

echo -e "${color}Adding User ${nocolor}"
useradd roboshop &>>${log_file}

echo -e "${color}Removing default content ${nocolor}"
rm -rf ${app_path} &>>${log_file}
mkdir ${app_path}

echo -e "${color}Downloading the $component content ${nocolor}"
curl -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component.zip &>>${log_file}
cd ${app_path}

echo -e "${color}Extract the $component content ${nocolor}"
unzip /tmp/$component.zip &>>${log_file}
cd ${app_path}

echo -e "${color}Installing NodeJS Depenencies ${nocolor}"
npm install &>>${log_file}

echo -e "${color}Copy Service files ${nocolor}"
cp /root/roboshop-shell/$component.service /etc/systemd/system/$component.service

echo -e "${color}Reload files ${nocolor}"
systemctl daemon-reload &>>${log_file}

echo -e "${color}Start the $component Server ${nocolor}"
systemctl enable $component &>>${log_file}
systemctl restart $component &>>${log_file}

echo -e "${color}Copy the MongoDB Repo Service ${nocolor}"
cp /root/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongo.repo

echo -e "${color}Install Mongodb Server ${nocolor}"
yum install mongodb-org-shell -y &>>${log_file}

echo -e "${color}Schema files load ${nocolor}"
mongo --host mongodb-dev.thisiszaheer.online <${app_path}/schema/$component.js &>>${log_file}