#!/bin/bash -x

source ./adduser.sh
source ./init_mongo.sh
source ./init_python_env.sh


adduser crawler b62a0-c78f

#创建虚拟环境
createVirtualEnv(){
    virtualenv ~crawler/venv
    source ~crawler/venv/bin/activate
}

#部署爬虫
deploy_spider(){
    cp -rf ./sxs_spider/ ~crawler/
    pip install -r ~crawler/sxs_spider/requirements.txt
}
deploy_spider

#为supervisor 顺利运行做准备工作
prepare_for_supervisor(){
    mkdir -p /var/crawler/logs/xmly
    mkdir -p /var/crawler/logs/kl
    mkdir -p /var/crawler/logs/qt
    mkdir -p /var/crawler/raw_data
    mkdir -p /var/crawler/logs/live
    mkdir -p /etc/supervisor
}

prepare_for_supervisor

generate_supervisor_conf(){
    cat > /etc/supervisord.conf <<EOF
$(echo_supervisord_conf)
[include]
files = /etc/supervisor/*.conf
EOF
}
generate_supervisor_conf

start_supervisor(){
    cp ./supervisor_conf/* /etc/supervisor/
}

start_supervisor


cat > foo.txt <<EOF
Hello
World
Linux
PWD=$(pwd)
EOF

