echo -e "\e[31mInstalling Nginx Server\e[0m"
yum install nginx -y &>>/tmp/roboshop.log

echo -e "\e[32mRemoving Default Content on Server\e[0m"
rm -rf /usr/share/nginx/html/* &>>/tmp/roboshop.log

echo -e "\e[33mDownloading Frontend Content\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>/tmp/roboshop.log

echo -e "\e[34mExtracting the Frontend Content\e[0m"
cd /usr/share/nginx/html &>>/tmp/roboshop.log
unzip /tmp/frontend.zip &>>/tmp/roboshop.log

echo -e "\e[36mUpdate Config Files\e[0m"
cp roboshop.conf /etc/nginx/default.d/roboshop.conf

echo -e "\e[35mStarting Nginx Server\e[0m"
systemctl enable nginx &>>/tmp/roboshop.log
systemctl restart nginx &>>/tmp/roboshop.log