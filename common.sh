color="\e[36m"
nocolor="\e[0m"
log_file="/tmp/roboshop.log"
app_path="/app"


app_presetup()
{
    echo -e "${color}Adding User ${nocolor}"
    useradd roboshop &>>${log_file}

    echo -e "${color}Removing default content ${nocolor}"
    rm -rf ${app_path} &>>${log_file}
    mkdir ${app_path}

    echo -e "${color}Downloading the $component content ${nocolor}"
    curl -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component.zip &>>${log_file}
    cd ${app_path}

    echo -e "${color}Extract the $component content ${nocolor}"
    cd ${app_path}
    unzip /tmp/$component.zip &>>${log_file}

}
nodejs()
{
  echo -e "${color}Configuration files ${nocolor}"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log_file}

  echo -e "${color}Installing NodeJS ${nocolor}"
  yum install nodejs -y &>>${log_file}

  app_presetup

  echo -e "${color}Installing NodeJS Depenencies ${nocolor}"
  npm install &>>${log_file}

  echo -e "${color}Copy Service files ${nocolor}"
  cp /root/roboshop-shell/$component.service /etc/systemd/system/$component.service

  echo -e "${color}Reload files ${nocolor}"
  systemctl daemon-reload &>>${log_file}

  echo -e "${color}Start the $component Server ${nocolor}"
  systemctl enable $component &>>${log_file}
  systemctl restart $component &>>${log_file}
}
mongodb_schema_setup()
{
  echo -e "${color}Copy the MongoDB Repo Service ${nocolor}"
  cp /root/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongo.repo

  echo -e "${color}Install Mongodb Server ${nocolor}"
  yum install mongodb-org-shell -y &>>${log_file}

  echo -e "${color}Schema files load ${nocolor}"
  mongo --host mongodb-dev.thisiszaheer.online <${app_path}/schema/$component.js &>>${log_file}
}
maven()
{
  echo -e "${color} Installing Maven${nocolor}"
  yum install maven -y &>>${log_file}
  app_presetup
  echo -e "${color} Installing Dependcies of Maven${nocolor}"
  mvn clean package &>>${log_file}
  mv target/shipping-1.0.jar shipping.jar &>>${log_file}
  echo -e "${color} Copying the Shipping Service${nocolor}"
  cp /root/roboshop-shell/shipping.service /etc/systemd/system/shipping.service &>>${log_file}
  echo -e "${color} Reloading the Service${nocolor}"
  systemctl daemon-reload &>>${log_file}
  echo -e "${color} Installing MySQL${nocolor}"
  yum install mysql -y &>>${log_file}
  echo -e "${color} Loading Schema${nocolor}"
  mysql -h mysql-dev.thisiszaheer.online -uroot -pRoboShop@1 < /app/schema/shipping.sql &>>${log_file}
  echo -e "${color} Enable & Restart the Service${nocolor}"
  systemctl enable shipping &>>${log_file}
  systemctl restart shipping &>>${log_file}
}