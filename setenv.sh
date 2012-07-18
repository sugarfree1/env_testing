#!/bin/bash

CURR_DIR=`pwd`

regex='/(\w+)\.git';
if [[ $(echo `git remote show origin` | grep 'Fetch URL') =~ $regex ]]; then
  PROJECT_NAME=${BASH_REMATCH[1]}
else 
  PROJECT_NAME=`basename $CURR_DIR`
fi

LIB_DIR=$CURR_DIR/lib
APP_DIR=$CURR_DIR/apps
ENV_DIR=$CURR_DIR/.env_$PROJECT_NAME

ENV_ACTIVATOR=$ENV_DIR/bin/activate

killall python 2>/dev/null

echo
echo "Setting up environment ..."
virtualenv --python=python2.7 ${ENV_DIR}
cat >>${ENV_ACTIVATOR} <<-EOF
	export PYTHONPATH=${LIB_DIR}
	export DJANGO_SETTINGS_MODULE=settings
EOF

source ${ENV_ACTIVATOR}


PATH=`pwd`/distribute_setup.py
echo "Couldn't delete "$PATH
echo
echo "Done"

