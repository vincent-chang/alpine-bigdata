#!/bin/bash
set -e

sql_file=`mktemp`
if [ ! -f "$sql_file" ]; then
    return 1
fi

cat << EOF > $sql_file
CREATE DATABASE IF NOT EXISTS hive;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY "${MYSQL_PASSWORD}";
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'localhost' IDENTIFIED BY "${MYSQL_PASSWORD}";
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO ${MYSQL_USER} WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOF

mysql -uroot -p${MYSQL_ROOT_PASSWORD}< $sql_file
rm -f $sql_file

echo "Run hive-txn-schema.mysql.sql"
mysql -u${MYSQL_USER} -p${MYSQL_PASSWORD} -D${MYSQL_DATABASE} < /tmp/hive-schema.mysql.sql

echo "Run hive-txn-schema.mysql.sql"
mysql -u${MYSQL_USER} -p${MYSQL_PASSWORD} -D${MYSQL_DATABASE} < /tmp/hive-txn-schema.mysql.sql