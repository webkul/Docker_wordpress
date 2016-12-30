temp=`cat /etc/flag`
sed -i "s/dbpassword/$temp/g" /var/www/wordpress/wp-config.php

