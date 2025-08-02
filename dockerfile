FROM ubuntu:24.04

# 查看代理
# systemctl show --property=Environment docker

# docker build -t typemoonl/rei:latest .
# docker build \
#   --build-arg http_proxy=http://127.0.0.1:7890 \
#   --build-arg https_proxy=http://127.0.0.1:7890 \
# docker build --build-arg http_proxy=http://192.168.51.198:7890 --build-arg https_proxy=http://192.168.51.198:7890 -t typemoonl/rei:latest .
# docker build --progress=plain -t typemoonl/rei:latest .
# CGO_ENABLED=0 GOARCH=amd64 go build -o ./rei -a -ldflags '-extldflags "-static"' main.go

# apt diy
# RUN mkdir -p /home/rei/apt_back
# RUN cp /etc/apt/sources.list.d/ubuntu.sources /home/rei/apt_back/
# COPY ./docker/ubuntu.sources /etc/apt/sources.list.d/ubuntu.sources
# RUN sed -i 's|http://archive.ubuntu.com/ubuntu/|https://mirrors.aliyun.com/ubuntu/|g' /etc/apt/sources.list

RUN apt-get update && apt-get install -y \
    bash \
    procps \
    grep \
    vim \
    curl \
    iputils-ping \
    net-tools sqlite3 libsqlite3-dev systemd sudo supervisor openssh-server unzip

COPY ./docker/sqlite_sh/supervisord.conf /etc/supervisord.conf
RUN mkdir -p /home/rei/supervisor

COPY ./docker/etc_conf/sshd_config /etc/ssh/sshd_config
RUN mkdir /run/sshd

RUN useradd -s /bin/bash -d /home/kotori kotori
WORKDIR /home/kotori
RUN echo "kotori:ichinoserei" | chpasswd
RUN mkdir /home/kotori/mysql
COPY ./docker/etc_conf/sudoers /etc/sudoers
RUN chmod u=r,g=r,o= /etc/sudoers

WORKDIR /home/rei
RUN mkdir /home/rei/proc_logs

RUN echo $(pwd)
RUN mkdir -p /home/rei/sunny_peace_rei/supervisor


COPY ./conf ./sunny_peace_rei/conf
COPY ./logs ./sunny_peace_rei/logs
COPY ./resources ./sunny_peace_rei/resources
COPY ./rei ./sunny_peace_rei/rei
COPY ./systemd ./sunny_peace_rei/systemd
COPY ./upload ./sunny_peace_rei/upload

RUN chmod +x /home/rei/sunny_peace_rei/rei
RUN chown -R kotori:kotori /home/rei /home/kotori

# 设置启动命令, 在claw cloud中使用supervisor进行管理
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
