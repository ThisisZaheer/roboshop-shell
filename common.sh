color="\e[35m"
nocolor="\e[0m"
log_file="/tmp/roboshop.log"
app_path="/app"


app_presetup()
{
    echo -e "${color}Adding User ${nocolor}"
    useradd roboshop &>>${log_file}
    if [ $? -eq 0 ]; then
      echo SUCCESS
    else
      echo FAILURE
    fi

    echo -e "${color}Removing default content ${nocolor}"
    rm -rf ${app_path} &>>${log_file}
    mkdir ${app_path}
    if [ $? -eq 0 ]; then
      echo SUCCESS
    else
      echo FAILURE
    fi
    echo -e "${color}Downloading the ${component} content ${nocolor}"
    curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>${log_file}
    cd ${app_path}
    if [ $? -eq 0 ]; then
      echo SUCCESS
    else
      echo FAILURE
   fi
    echo -e "${color}Extract the ${component} content ${nocolor}"
    cd ${app_path}
    unzip /tmp/${component}.zip &>>${log_file}
    if [ $? -eq 0 ]; then
      echo SUCCESS
    else
      echo FAILURE
    fi
}
systemd_setup()
{
    echo -e "${color}Copy Service files ${nocolor}"
    cp /root/roboshop-shell/${component}.service /etc/systemd/system/${component}.service
    if [ $? -eq 0 ]; then
      echo SUCCESS
    else
      echo FAILURE
    fi
    echo -e "${color}Start the ${component} Server ${nocolor}"
    systemctl daemon-reload &>>${log_file}
    systemctl enable ${component} &>>${log_file}
    systemctl restart ${component} &>>${log_file}
    if [ $? -eq 0 ]; then
      echo SUCCESS
    else
      echo FAILURE
    fi
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

    systemd_setup
}
mongodb_schema_setup()
{
    echo -e "${color}Copy the MongoDB Repo Service ${nocolor}"
    cp /root/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongo.repo

    echo -e "${color}Install Mongodb Server ${nocolor}"
    yum install mongodb-org-shell -y &>>${log_file}

    echo -e "${color}Schema files load ${nocolor}"
    mongo --host mongodb-dev.thisiszaheer.online <${app_path}/schema/${component}.js &>>${log_file}
}

mysql_schema_setup()
{
    echo -e "${color} Installing MySQL${nocolor}"
    yum install mysql -y &>>${log_file}

    echo -e "${color} Loading Schema${nocolor}"
    mysql -h mysql-dev.thisiszaheer.online -uroot -pRoboShop@1 < /app/schema/${component}.sql &>>${log_file}

}
maven()
{
    echo -e "${color} Installing Maven${nocolor}"
    yum install maven -y &>>${log_file}

    app_presetup

    echo -e "${color} Installing Dependcies of Maven${nocolor}"
    mvn clean package &>>${log_file}
    mv target/${component}-1.0.jar ${component}.jar &>>${log_file}

    systemd_setup
}
python()
{
    echo -e "${color} Installing Python 3.6 Version${nocolor}"
    yum install python36 gcc python3-devel -y &>>/tmp/roboshop.log
    if [ $? -eq 0 ]; then
      echo SUCCESS
    else
      echo FAILURE
    fi
    app_presetup

    echo -e "${color} Installing the Python Dependcies${nocolor}"
    pip3.6 install -r requirements.txt &>>/tmp/roboshop.log
    if [ $? -eq 0 ]; then
      echo SUCCESS
    else
      echo FAILURE
    fi

    systemd_setup
}