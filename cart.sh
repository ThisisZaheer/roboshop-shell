source common.sh
echo -e "\e[36m NodeJS Repo Files\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/roboshop.log
echo -e "\e[36m Installing NodeJS\e[0m"
yum install nodejs -y &>>/tmp/roboshop.log
echo -e "\e[36m Adding Cart User\e[0m"
useradd roboshop &>>/tmp/roboshop.log
echo -e "\e[36m Removing Any Default Content is Existed\e[0m"
rm -rf /app &>>/tmp/roboshop.log
mkdir /app
echo -e "\e[36m Downloading the Cart Service files\e[0m"
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip &>>/tmp/roboshop.log
cd /app
echo -e "\e[36m Extracting the Cart Files\e[0m"
unzip /tmp/cart.zip &>>/tmp/roboshop.log
cd /app
echo -e "\e[36m Installing NodeJS Dependency\e[0m"
npm install &>>/tmp/roboshop.log
echo -e "\e[36m Copying Cart Service\e[0m"
cp /root/roboshop-shell/cart.service /etc/systemd/system/cart.service
echo -e "\e[36m Reloading Cart Service\e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
echo -e "\e[36m Starting Cart Service\e[0m"
systemctl enable cart &>>/tmp/roboshop.log
systemctl restart cart &>>/tmp/roboshop.log