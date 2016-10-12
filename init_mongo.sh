#!/bin/bash -x

addMongoRepo(){

    cat > /etc/yum.repos.d/mongodb-org-3.2.repo<< EOF
[mongodb-org-3.2]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/\$releasever/mongodb-org/3.2/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-3.2.asc
EOF
}

installMongo(){
    echo "start install crawler env"

    addMongoRepo

    sudo yum install -y mongodb-org

    sudo service mongod start

    sudo chkconfig mongod on

    echo "mongo is now running,and the command is "
    echo "/usr/bin/mongod -f /etc/mongod.conf"
}

#将历史爬取数据恢复到部署环境中
importHistory(){
    echo "start import history data"
    unzip ./crawlHistory.zip
    cd crawlHistory
    mongoimport -d test_spider -c qt_item qt_item.dat > /dev/null 2>&1
    mongoimport -d test_spider -c qt_audio qt_audio.dat > /dev/null 2>&1
    mongoimport -d test_spider -c kl_album kl_album.dat > /dev/null 2>&1
    mongoimport -d test_spider -c kl_audio kl_audio.dat > /dev/null 2>&1
    mongoimport -d test_spider -c kl_category kl_category.dat > /dev/null 2>&1
    mongoimport -d test_spider -c xmly_album xmly_album.dat > /dev/null 2>&1
    mongoimport -d test_spider -c xmly_audio xmly_audio.dat > /dev/null 2>&1
    mongoimport -d test_spider -c xmly_category xmly_category.dat > /dev/null 2>&1
    cd ..
    echo "import history data succeed"
}

init_mongo(){
    addMongoRepo
    installMongo
    importHistory
}

