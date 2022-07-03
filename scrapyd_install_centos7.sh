#!/bin/bash
# 安装Python3
yum install -y python3
# 安装python3-devel
yum install -y python3-devel
# 安装dos2unix
yum install -y dos2unix
# 开始pip换源
pip3 install -i https://pypi.tuna.tsinghua.edu.cn/simple pip -U
pip config set global.index-url https://pypi.douban.com/simple/
# 升级pip
pip3 install --upgrade pip
# pip安装setuptools_rust
pip3 install setuptools_rust
# pip安装scrapyd
pip3 install scrapyd
# 开放6800端口
firewall-cmd --add-port=6800/tcp --permanent
# 重新加载防火墙
firewall-cmd --reload
# 重启防火墙
systemctl restart firewalld
# 下载scrapyd配置文件
mkdir "/etc/scrapyd/"
wget https://github.com/ppsxs/scrapyd_install/blob/main/scrapyd.conf -O /etc/scrapyd/scrapyd.conf
# 下载scrapyd自启配置文件
wget https://github.com/ppsxs/scrapyd_install/blob/main/scrapyd -O /etc/init.d/scrapyd
# 处理文件
dos2unix /etc/init.d/scrapyd
# 赋予文件755权限
chmod 755 /etc/init.d/scrapyd
# 创建文件夹
mkdir "/var/scrapyd"
# 添加开机自启
chkconfig --add scrapyd
# 启动scrapyd服务
service scrapyd start

echo "/etc/scrapyd/scrapyd.conf 添加账号密码"