#!/bin/bash
set -e

mysqld_count=`ps -ef|grep mysqld|grep -v grep|wc -l`
echo "mysqld_count: ${mysqld_count}"
if [ "${mysqld_count}" -eq "0" ]
then
  chmod +x /root/startup.sh
  nohup /root/startup.sh 2>&1 >/root/startup.log &
  sleep 5
fi

sql_file=`mktemp`
if [ ! -f "$sql_file" ]; then
    return 1
fi

cat << EOF > $sql_file
CREATE DATABASE IF NOT EXISTS hive;
CREATE USER IF NOT EXISTS '${HIVE_DB_USER}'@'%' IDENTIFIED BY "${HIVE_DB_PASSWORD}";
CREATE USER IF NOT EXISTS '${HIVE_DB_USER}'@'localhost' IDENTIFIED BY "${HIVE_DB_PASSWORD}";
GRANT ALL PRIVILEGES ON ${HIVE_DB_NAME}.* TO ${HIVE_DB_USER} WITH GRANT OPTION;
EOF

mysql -uroot < $sql_file
rm -f $sql_file
echo "Run hive-schema.mysql.sql"
mysql -u${HIVE_DB_USER} -p${HIVE_DB_PASSWORD} -D${HIVE_DB_NAME} </root/hive-schema.mysql.sql 2>&1 || true
echo "Run hive-txn-schema.mysql.sql"
mysql -u${HIVE_DB_USER} -p${HIVE_DB_PASSWORD} -D${HIVE_DB_NAME} </root/hive-txn-schema.mysql.sql 2>&1 || true
tail -f /root/startup.log