#!/bin/bash -x


updatePython(){
    pythonVersion=$(python -c 'import platform; print(platform.python_version())')
    echo $pythonVersion
    if [[ "$pythonVersion" = 2.7.12 ]]
    then
        echo "pythonVersion is already 2.7.12"
    else
        echo "start install python 2.7"  
        yum install openssl-devel
        yum install sqlite-devel
        yum -y install xz
        xz -d ./Python-2.7.12.tar.xz
        tar -xvf ./Python-2.7.12.tar
        cd Python-2.7.12
        ./configure
        make all
        make install 
        make clean 
        make distclean
        /usr/local/bin/python2.7 -V\
        mv /usr/bin/python /usr/bin/python2.6.6
        ln -s /usr/local/bin/python2.7 /usr/bin/python
        python -V
        cd ..
        pwd
        ls
        echo "please change yum header"
    fi
}


install_easy_install(){
    echo "install easy_install"
    tar -xzf distribute-0.6.49.tar.gz
    cd distribute-0.6.49
    python distribute_setup.py
    cd ..
}

install_pip(){
    echo "install pip "
    easy_install pip
    /usr/local/bin/pip -V
    ln -s /usr/local/bin/pip /usr/bin/pip
}

install_virtualenv(){
    pip install virtualenv
}

init_python_env(){
    updatePython
    install_easy_install
    install_pip
    install_virtualenv
}
