echo -e "\e[31mInstalling Nginx Server\e[0m"
yum install nginx -y
echo -e "\e[32mRemoving Default Content on Server\e[0m"
rm -rf /usr/share/nginx/html/*
echo -e "\e[33mDownloading Frontend Content\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip
echo -e "\e[34mExtracting the Frontend Content\e[0m"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip

# We need to copy the Conf File vim /etc/nginx/default.d/roboshop.conf
echo -e "\e[35mStarting Nginx Server\e[0m"
systemctl enable nginx
systemctl restart nginx