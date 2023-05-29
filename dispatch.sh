echo -e "\e[36m Installing GO Lang\e[0m"
yum install golang -y &>>/tmp/roboshop.log
echo -e "\e[36m Adding User Roboshop\e[0m"
useradd roboshop &>>/tmp/roboshop.log
echo -e "\e[36m Removing Old Content\e[0m"
rm -rf /app &>>/tmp/roboshop.log
mkdir /app &>>/tmp/roboshop.log
echo -e "\e[36m Downloading Dispatch files\e[0m"
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip &>>/tmp/roboshop.log
cd /app
echo -e "\e[36m Extracting the Files\e[0m"
unzip /tmp/dispatch.zip &>>/tmp/roboshop.log
cd /app
echo -e "\e[36m Installing Go Lang Dependcies\e[0m"
go mod init dispatch &>>/tmp/roboshop.log
go get &>>/tmp/roboshop.log
go build &>>/tmp/roboshop.log
echo -e "\e[36m Copying Payment.services\e[0m"
cp /root/roboshop-shell/dispatch.service /etc/systemd/system/dispatch.service &>>/tmp/roboshop.log
echo -e "\e[36m Reloading the Service\e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
echo -e "\e[36m Enable & restart services\e[0m"
systemctl enable dispatch &>>/tmp/roboshop.log
systemctl restart dispatch &>>/tmp/roboshop.log