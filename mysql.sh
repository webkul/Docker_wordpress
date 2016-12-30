tmp=`cat /etc/flag`
mysql -u root<<EOF
create database test;
create user admin;
grant all privileges on *.* to 'admin'@'%' identified by '$tmp';
EOF
