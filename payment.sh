echo -e "\e[36m>>>>>>>>>>>>>>>>>>>>>> Install python <<<<<<<<<<<<<<<<<<<<<<<<\e[0m"
yum install python36 gcc python3-devel -y

echo -e "\e[36m>>>>>>>>>>>>>>>>>>>>>> add the user <<<<<<<<<<<<<<<<<<<<<<<<\e[0m"
useradd roboshop

echo -e "\e[36m>>>>>>>>>>>>>>>>>>>>>> create a directory <<<<<<<<<<<<<<<<<<<<<<<<\e[0m"
rm -rf /app
mkdir /app

echo -e "\e[36m>>>>>>>>>>>>>>>>>>>>>> download the payment content <<<<<<<<<<<<<<<<<<<<<<<<\e[0m"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip
cd /app

echo -e "\e[36m>>>>>>>>>>>>>>>>>>>>>> extract the payment content <<<<<<<<<<<<<<<<<<<<<<<<\e[0m"
unzip /tmp/payment.zip
cd /app

echo -e "\e[36m>>>>>>>>>>>>>>>>>>>>>> Install dependencies   <<<<<<<<<<<<<<<<<<<<<<<<\e[0m"
pip3.6 install -r requirements.txt

echo -e "\e[36m>>>>>>>>>>>>>>>>>>>>>> copy the payment systemd file <<<<<<<<<<<<<<<<<<<<<<<<\e[0m"
cp /home/centos/roboshop_shell/payment.service /etc/systemd/system/payment.service

echo -e "\e[36m>>>>>>>>>>>>>>>>>>>>>> start payment service <<<<<<<<<<<<<<<<<<<<<<<<\e[0m"
systemctl daemon-reload
systemctl enable payment
systemctl restart payment