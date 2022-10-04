Content-Type: multipart/mixed; boundary="//"
MIME-Version: 1.0

--//
Content-Type: text/cloud-config; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="cloud-config.txt"

#cloud-config
cloud_final_modules:
- [scripts-user, always]

--//
Content-Type: text/x-shellscript; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="userdata.txt"
 
#!/bin/bash
sudo su
yum update -y
amazon-linux-extras install nginx1 -y

# Install PHP 8.0
amazon-linux-extras enable php8.0
yum clean metadata
yum install php php-cli php-mysqlnd php-pdo php-common php-fpm -y
yum install php-gd php-mbstring php-xml php-dom php-intl php-simplexml -y
systemctl enable php-fpm
service php-fpm start
systemctl enable nginx

# Move web site configure file to /etc/nginx/conf.d/
cp /home/ec2-user/phpsite.conf /etc/nginx/conf.d/

# Move phpsite to /var/www/ to advoid forbidden error 403
mv /home/ec2-user/phpsite /var/www/

# Start Nginx
service nginx start
