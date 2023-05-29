echo -e "\e[33m Disabling Newer Version of MysQl\e[0m"
yum module disable mysql -y &>>/tmp/roboshop.log

echo -e "\e[33m Copying Repo Service Files\e[0m"
cp /root/roboshop-shell/mysql.repo /etc/yum.repos.d/mysql.repo &>>/tmp/roboshop.log

echo -e "\e[33m Installing Mysql Community Version\e[0m"
yum install mysql-community-server -y &>>/tmp/roboshop.log

echo -e "\e[33m Enabling & Starting MysQl\e[0m"
systemctl enable mysqld &>>/tmp/roboshop.log
systemctl restart mysqld &>>/tmp/roboshop.log

echo -e "\e[33m Password of MysQl\e[0m"
mysql_secure_installation --set-root-pass RoboShop@1 &>>/tmp/roboshop.log

