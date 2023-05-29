echo -e "\e[33m Installing Python 3.6 Version\e[0m"
yum install python36 gcc python3-devel -y &>>/tmp/roboshop.log
echo -e "\e[33m Useradd Roboshop\e[0m"
useradd roboshop &>>/tmp/roboshop.log
echo -e "\e[33m Removing existed content\e[0m"
rm -rf /app &>>/tmp/roboshop.log
mkdir /app
echo -e "\e[33m Downloading the Content\e[0m"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip &>>/tmp/roboshop.log
cd /app
echo -e "\e[33m Extracting the files\e[0m"
unzip /tmp/payment.zip &>>/tmp/roboshop.log
cd /app
echo -e "\e[33m Downloading the dependencies\e[0m"
pip3.6 install -r requirements.txt &>>/tmp/roboshop.log
echo -e "\e[33m Copying the Payment.service files\e[0m"
cp /root/roboshop-shell/payment.service /etc/systemd/system/payment.service &>>/tmp/roboshop.log
echo -e "\e[33m Reloading the System\e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
echo -e "\e[33m Enable & Restart Service\e[0m"
systemctl enable payment &>>/tmp/roboshop.log
systemctl restart payment &>>/tmp/roboshop.log