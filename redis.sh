echo -e "\e[33mInstalling Redis Repo File\e[0m"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>>/tmp/roboshop.log
echo -e "\e[33mEnabling Redis\e[0m"
yum module enable redis:remi-6.2 -y &>>/tmp/roboshop.log
echo -e "\e[33mInstall Redis server\e[0m"
yum install redis -y &>>/tmp/roboshop.log
echo -e "\e[33mupdating IP Address\e[0m"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis.conf
echo -e "\e[33mStart Redis Directory\e[0m"
systemctl enable redis &>>/tmp/roboshop.log
systemctl start redis &>>/tmp/roboshop.log