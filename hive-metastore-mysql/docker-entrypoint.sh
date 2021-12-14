#!/bin/bash
set -e

if [ ! -d /var/run/mysql ]; then
  mkdir -p /var/run/mysql
fi

init="N"

if [ -d /var/mysql/data ]; then
  echo "[i] MySQL directory already present, skipping creation"
else
  init="Y"

  echo "[i] MySQL data directory not found, creating initial DBs"

  mysql_install_db --user=root > /dev/null

  if [ "$MYSQL_ROOT_PASSWORD" = "" ]; then
    MYSQL_ROOT_PASSWORD=root
    echo "[i] MySQL root Password: $MYSQL_ROOT_PASSWORD"
  fi

  MYSQL_DATABASE=${MYSQL_DATABASE:-""}
  MYSQL_USER=${MYSQL_USER:-""}
  MYSQL_PASSWORD=${MYSQL_PASSWORD:-""}

  sql_file=`mktemp`
  if [ ! -f "$sql_file" ]; then
      return 1
  fi

  cat << EOF > $sql_file
USE mysql;
FLUSH PRIVILEGES;
CREATE USER IF NOT EXISTS 'root'@'%' IDENTIFIED BY "${MYSQL_ROOT_PASSWORD}";
CREATE USER IF NOT EXISTS 'root'@'localhost' IDENTIFIED BY "${MYSQL_ROOT_PASSWORD}";
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY "${MYSQL_ROOT_PASSWORD}" WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' IDENTIFIED BY "${MYSQL_ROOT_PASSWORD}" WITH GRANT OPTION;
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE} CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY "${MYSQL_PASSWORD}";
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'localhost' IDENTIFIED BY "${MYSQL_PASSWORD}";
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO ${MYSQL_USER} WITH GRANT OPTION;
EOF

  /usr/bin/mysqld --user=root --bootstrap --verbose=0 < $sql_file
  rm -f $sql_file

fi

nohup /usr/bin/mysqld --user=root --console >/var/mysql/mysql.log 2>&1 &

if [ "$init" == "Y" ]; then
  sleep 5
  mysql -u${MYSQL_USER} -p${MYSQL_PASSWORD} -D${MYSQL_DATABASE} </tmp/hive-schema.mysql.sql
  mysql -u${MYSQL_USER} -p${MYSQL_PASSWORD} -D${MYSQL_DATABASE} </tmp/hive-txn-schema.mysql.sql
fi

exec tail -f /var/mysql/mysql.log