echo -e "\e[32m Installing Maven\e[0m"
yum install maven -y &>>/tmp/roboshop.log
echo -e "\e[32m Adding User\e[0m"
useradd roboshop &>>/tmp/roboshop.log
echo -e "\e[32m Removing Existing Content\e[0m"
rm -rf /app &>>/tmp/roboshop.log
mkdir /app
echo -e "\e[32m Downloading the Content\e[0m"
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip &>>/tmp/roboshop.log
cd /app
echo -e "\e[32m Extracting the Files\e[0m"
unzip /tmp/shipping.zip &>>/tmp/roboshop.log
cd /app
echo -e "\e[32m Installing Dependcies of Maven\e[0m"
mvn clean package &>>/tmp/roboshop.log
mv target/shipping-1.0.jar shipping.jar &>>/tmp/roboshop.log
echo -e "\e[32m Copying the Shipping Service\e[0m"
cp /root/roboshop-shell/shipping.service /etc/systemd/system/shipping.service &>>/tmp/roboshop.log
echo -e "\e[32m Reloading the Service\e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
echo -e "\e[32m Installing MySQL\e[0m"
yum install mysql -y &>>/tmp/roboshop.log
echo -e "\e[32m Loading Schema\e[0m"
mysql -h mysql-dev.thisiszaheer.online -uroot -pRoboShop@1 < /app/schema/shipping.sql &>>/tmp/roboshop.log
echo -e "\e[32m Enable & Restart the Service\e[0m"
systemctl enable shipping &>>/tmp/roboshop.log
systemctl restart shipping &>>/tmp/roboshop.log