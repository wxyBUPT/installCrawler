#!/bin/bash 

demoFun(){
    echo "这是我的第一个函数"
}

echo "----函数开始执行 ----"
demoFun
echo "-----函数执行完毕 ----"

foo(){
    cat > foo.txt << EOF
    a
    b
    c
EOF
    echo "foo"
}

bar(){
    foo
    echo "bar"
}
bar


gen(){
    cat > foo.conf <<EOF
$(echo_supervisord_conf)
[include]
file = /etc/supervisor/*.conf
EOF
}
gen

