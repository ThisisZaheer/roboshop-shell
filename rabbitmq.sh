echo -e "\e[34m Configuring Repo files of vendor\e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash &>>/tmp/roboshop.log
echo -e "\e[34m Configuring Repo files of RabbitMQ\e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash &>>/tmp/roboshop.log
echo -e "\e[34m Installing RabbitMQ Server\e[0m"
yum install rabbitmq-server -y &>>/tmp/roboshop.log
echo -e "\e[34m Enable & Restart RabbitMQ\e[0m"
systemctl enable rabbitmq-server &>>/tmp/roboshop.log
systemctl restart rabbitmq-server &>>/tmp/roboshop.log
echo -e "\e[34m User & Password for Roboshop\e[0m"
rabbitmqctl add_user roboshop $1 &>>/tmp/roboshop.log
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>/tmp/roboshop.log