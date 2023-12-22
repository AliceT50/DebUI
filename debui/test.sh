#!/bin/bash

distribution=ubuntu

if [ $distribution = debian ]; then
    echo -e "test1"

elif [ $distribution = ubuntu ]; then
    echo -e "test2"
fi