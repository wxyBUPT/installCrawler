#!/bin/bash  

install_supervisor(){
    pip install supervisor
}

prepare_for_supervisor(){
    mkdir -p /var/crawler/logs/xmly
    mkdir -p /var/crawler/logs/kl
    mkdir -p /var/crawler/logs/qt
    mkdir -p /var/crawler/raw_data
    mkdir -p /var/crawler/logs/live
    mkdir -p /etc/supervisor
    mkdir -p /var/crawler/logs/cnr
    mkdir -p /var/crawler/logs/statistic_web
}

generate_supervisor_conf(){
    cat > /etc/supervisord.conf <<EOF
$(echo_supervisord_conf)
[include]
files = /etc/supervisor/*.conf
EOF
}

start_supervisor(){
    yes | cp ./supervisor_conf/* /etc/supervisor/
    supervisord -c /etc/supervisord.conf
}

conf_supervisor(){
    install_supervisor
    prepare_for_supervisor
    generate_supervisor_conf
    start_supervisor
}

