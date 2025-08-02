#!/bin/bash
set -e

# Entrypoint for MySQL in Docker

# 首次初始化数据库并设置 root 密码
echo "Initializing database..."
if [ ! -d "/var/lib/mysql/mysql" ]; then
  mysqld --initialize-insecure --user=mysql --datadir=/var/lib/mysql

  echo "Configuring root password..."
  # 启动临时 MySQL 实例
  mysqld_safe --skip-networking &
  pid="$!"

  # 等待 mysqld 可用
  for i in {30..0}; do
    mysqladmin ping &>/dev/null && break
    echo "Waiting for mysqld to be ready..."
    sleep 1
  done

  # 设置 root 密码
  mysql -u root -e "ALTER USER 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD'; FLUSH PRIVILEGES;"
  mysql -u root -e "
  CREATE DATABASE IF NOT EXISTS rei;
  CREATE USER IF NOT EXISTS 'printemps'@'%' IDENTIFIED BY 'lovelive';
  GRANT ALL PRIVILEGES ON rei.* TO 'printemps'@'%';
  FLUSH PRIVILEGES;"

  # 关闭临时 MySQL 实例
  mysqladmin -u root -p "$MYSQL_ROOT_PASSWORD" shutdown
  wait "$pid"
  
fi

/usr/bin/supervisord -c /etc/supervisord.conf &

# if [ -f /home/rei/mysql_shell/init.sql ]; then
#     echo "Running init.sql..."
#     mysql -u root -p "${MYSQL_ROOT_PASSWORD}" < /home/rei/mysql_shell/init.sql
# fi

# 切换到 mysql 用户并执行 CMD
# exec gosu mysql "$@"
# exec gosu mysql mysqld &
exec "$@"
