#! /bin/bash
#! /bin/bash

if [ $USER != "root" ]
then 
echo "Run this script with sudo permission"

else
	printf "1. Install Wordpress with LAMP stack\n2. Remove Wordpress with LAMP stack\n3. Exit\n"
	read choice
	if [ $choice = 1 ]
	then
		printf "\n-------------------------Installing APACHE2 -----------------------\n"
		apt-get install apache2 -y
		printf "\n-------------------------APACHE2 DONE------------------------------\n"
		printf "\n-------------------------Installing PHP and other PHP PACKAGES ----\n"
		apt-get install php php-curl php-xml libapache2-mod-php php-mysql php-mbstring -y
		printf "\n-------------------------PHP DONE----------------------------------\n"
		printf "\n-------------------------Installing MYSQL -------------------------\n"
		apt-get install mysql-server mysql-client -y
		printf "\n-------------------------SECURE MYSQL INSTALLATION ----------------\n"
		mysql_secure_installation
		read -s -p  "Enter your mysql password : " mysqlpwd
		mysql -u root -p$mysqlpwd -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '$mysqlpwd'; flush privileges;"
		printf "\n-------------------------MYSQL DONE -------------------------------\n"
		printf "\n-------------------------INSTALLING PHPMYADMIN --------------------\n"
		apt-get install phpmyadmin
		printf "\n-------------------------PHPMYADMIN INSTALLED ---------------------\n"
		phpenmod mbstring
		printf "\nrestarting apache2"
		systemctl restart apache2
		printf "\napache2 restarted"
		printf "\n-------------------Downloading wordpress tar.gz file --------------\n"
		wget https://wordpress.org/latest.tar.gz
		printf "\n-------------------Download Complete. Extracting the file now -----\n"
		rm /var/www/html/index.html
		tar -zxvf latest.tar.gz -C /var/www/html
		mv /var/www/html/wordpress/* /var/www/html
		rm latest.tar.gz
		printf "\n~~~~~~~~~~~~~~~~~~~~~~~~~Wordpress Installed~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
		
	elif [ $choice = 2 ]
	then	
		printf "\n---------------------- Uninstall Started ---------------------------------\n"
		apt purge mysql* -y
		apt purge phpmyadmin -y
		apt purge apache2* -y
		apt purge php* -y
		apt autoremove -y
		printf "\n---------------------- Uninstall Completed ---------------------------------\n"
	 
	elif [ $choice = 3 ]
	then
		printf "Bye ..\n"
	else
		printf "Choose The correct option"
		printf "\n-----------\n"
	fi


fi



