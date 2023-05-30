source common.sh
component=catalogue

nodejs

echo -e "${color}Copy the MongoDB Repo Service ${nocolor}"
cp /root/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongo.repo

echo -e "${color}Install Mongodb Server ${nocolor}"
yum install mongodb-org-shell -y &>>${log_file}

echo -e "${color}Schema files load ${nocolor}"
mongo --host mongodb-dev.thisiszaheer.online <${app_path}/schema/$component.js &>>${log_file}