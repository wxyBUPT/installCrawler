#!/bin/bash

adduser(){
    if id $1
    then
        echo "The user $1 is exist!"
        echo "Change user $1 passw"
        echo $2|passwd --stdin $1
        echo username is $1, and new passwd is $2
    else
        useradd $1
        echo $2|passwd --stdin $1
        echo "username is $1, and password is $2"
    fi
}

