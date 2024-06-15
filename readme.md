# MariaDB quick start 
- Last change: 2023-05-11, 14-00 
- This guide explains how to install and access MariaDB Server. 
- The setup process (steps 1, 2, 3) is different for each operating system. 
- See https://mariadb.com/ for detailed instructions. 

## 1. Installation 
- [Debian-based] $ sudo apt install mariadb-server 
- [Fedora-based] $ sudo dnf install mariadb-server 
- [MacOS] $ sudo brew install mariadb-server 
- [Windows] $ winget install mariadb-server or https://mariadb.com/kb/en/installing-mariadb-msi-packages-on-windows/ 

## 2. Enable automatic launch on system boot 
- [most Linux systems] $ sudo systemctl enable mariadb 
- [MacOS] $ brew services start mariadb 
- [Windows] Use the graphical user interface. 

## 3. Start the server 
- [most Linux systems] $ sudo systemctl start mariadb 
- [MacOS] $ mysql.server start 
- [Windows] Use the graphical user interface. 

## 4. Create user 
- Open the MariaDB command line interpreter as administrator. $ sudo mysql -u root -p 
- Create a new user. Replace and . $ CREATE USER ''@'localhost' IDENTIFIED BY ''; 
- Grant permissions to the newly created user. Replace . [OPTIONAL] Use % instead of localhost (and change file my.cnf) to allow access from other machines (not necessary or recommended for the tutorial). $ GRANT ALL PRIVILEGES ON *.* TO ''@'localhost'; 
- Materialize permission changes and exit. $ FLUSH PRIVILEGES; $ EXIT; 

## 5. Create database 
- Open the MariaDB command line interpreter as the newly created user. Replace . $ mysql -u -p - Create a new database. Replace . $ CREATE DATABASE IF NOT EXISTS ; 
- Switch to the newly created database. Replace . $ USE ; 
- You can now use regular SQL statements. E.g. $ CREATE TABLE ...; $ INSERT ...; $ UPDATE ...; $ SELECT ...; $ ...; 

## Helpful commands 
- Show existing tables. $ SHOW TABLES 
- Show table details. Replace . $ DESCRIBE