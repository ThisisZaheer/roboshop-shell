source common.sh
component=cart
color="\e[36m"
nocolor="\e[0m"
log_file="/tmp/roboshop.log"
app_path="/app"

echo -e "${color} NodeJS Repo Files${nocolor}"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log_file}
echo -e "${color} Installing NodeJS${nocolor}"
yum install nodejs -y &>>${log_file}
echo -e "${color} Adding ${component} User${nocolor}"
useradd roboshop &>>${log_file}
echo -e "${color} Removing Any Default Content is Existed${nocolor}"
rm -rf ${app_path} &>>${log_file}
mkdir ${app_path}
echo -e "${color} Downloading the ${component} Service files${nocolor}"
curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>${log_file}
cd ${app_path}
echo -e "${color} Extracting the ${component} Files${nocolor}"
unzip /tmp/${component}.zip &>>${log_file}
cd ${app_path}
echo -e "${color} Installing NodeJS Dependency${nocolor}"
npm install &>>${log_file}
echo -e "${color} Copying ${component} Service${nocolor}"
cp /root/roboshop-shell/${component}.service /etc/systemd/system/${component}.service
echo -e "${color} Reloading ${component} Service${nocolor}"
systemctl daemon-reload &>>${log_file}
echo -e "${color} Starting ${component} Service${nocolor}"
systemctl enable ${component} &>>${log_file}
systemctl restart ${component} &>>${log_file}