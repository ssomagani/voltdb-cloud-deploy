#! /bin/bash

password=`sudo grep password /etc/mysql/debian.cnf | tail -1 | awk '{print $3}'`
user=`sudo grep user /etc/mysql/debian.cnf | tail -1 | awk '{print $3}'`

mysql -u $user -p $password 


drop user symmetricds@localhost;
flush privileges;
CREATE USER 'symmetricds'@'localhost' IDENTIFIED BY 'password';

mysql -u symmetricds -p < sym_ddl.sql

sudo vi /etc/mysql/mysql.conf.d/mysqld.cnf
	