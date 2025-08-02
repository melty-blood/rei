## 本项目来自 https://github.com/go-sonic/sonic.git, 在这上面做了些修改, 主要改动是默认的主题


## 代号: Rei


```shell
# 编译
CGO_ENABLED=1 GOARCH=amd64 go build -o ./rei -a main.go


# dockerfile
docker build --progress=plain -t typemoonl/rei:latest .
# 可以先跑一下本地测试看是否ok, 然后在推送
docker run -tid --name rei_blog -p 8080:8080 -p 22876:22876 --restart=always --privileged=true typemoonl/rei

docker run -tid -p 8800:8080 -p 22876:22876 --privileged=true --name rei_blog typemoonl/rei /home/rei/mysql_shell/entrypoint.sh
docker run -tid -p 8800:8080 -p 22876:22876 --privileged=true --name rei_blog typemoonl/rei /bin/bash -c "mysql -u root -p lovelive < /home/rei/mysql_shell/init.sql"


-e MYSQL_ROOT_PASSWORD=765876 -p 22380:3306

# 如果是mysql
/usr/lib/systemd/system/mysql.service
ExecStartPre=/usr/share/mysql-8.0/mysql-systemd-start pre
去掉 `+` 符号




docker tag typemoonl/rei:latest typemoonl/rei:sqlite
docker push typemoonl/rei:sqlite

```

## supervisor配置变了
```shell
supervisorctl -c /etc/supervisord.conf
reread
update
start rei

```


![idoly_pride_sp.jpg](./idoly_pride_sp.jpg)

