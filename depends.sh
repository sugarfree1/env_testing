#!/bin/bash

if [ ${0:0:1} == "/" ]; then
	HERE=$(dirname $0)
else
	HERE=$(dirname $(pwd)/$0)
fi

SETENV=${HERE}/setenv.sh

PACKAGES="postgresql sqlite3"

echo
echo "Installing python2.7 ..."
sudo apt-get install -qq python2.7 python2.7-dev curl
if ! curl -O http://python-distribute.org/distribute_setup.py>/dev/null
then
  echo "Failed downloading from http://python-distribute.org/distribute_setup.py"
fi

sudo python2.7 distribute_setup.py>/dev/null
sudo apt-get install -qq build-essential ${PACKAGES}
echo
echo "Installing pip, virtualenv ..."
sudo easy_install-2.7 pip
sudo pip-2.7 install --quiet virtualenv
#sudo easy_install -q -U pip
#sudo easy_install -q -U virtualenv

echo "Shutdowning python ..."
killall python 2>/dev/null


echo "Installing requirements ..."
source ${SETENV} >/dev/null
for REQMT in ${LIB_DIR}/*/requirements.txt ${APP_DIR}/*/requirements.txt $CURR_DIR/requirements.txt
do
	if [ -s ${REQMT} ]
	then
		echo " [${REQMT}]"
		pip-2.7 install -r ${REQMT}
	fi
done

echo
echo "Done"
