#!/usr/bin/env bash

# This script lives in git, but I assume it will initially be copy/ pasted in a target machine
# where the target machine has nothing at all installed (but has at least an internet connection)
# This script should install all of the dependencies of the Vantiq Server necessary for running on 
# an ARM device, as well as install the vantiq server itself

USRNAME="$1"
PASSWD="$2"

echo "Using the following credentials to clone ag2rs: $USRNAME $PASSWD\n"

# set up database data directory
pushd /

mkdir -p data
chmod 755 data

popd # /

# Raspbian currently ships with Oracle JDK 1.8, so we should be good on the Java front
# We will need to install and setup h2
# we're going to install h2 into /usr/share
pushd /usr/share
# install h2gis, which includes h2 and it's dependencies
wget https://github.com/orbisgis/h2gis/releases/download/v1.2.3/h2-dist-1.2.3-bin.zip -O h2gis.zip
unzip h2gis.zip

# Get the Vantiq server
git clone https://$USRNAME:$PASSWD@github.com/Vantiq/ag2rs.git
# Get Vantiq UI
git clone https://$USRNAME:$PASSWD@github.com/Vantiq/iqtools.git
# Create symbolic link in Server that points to UI
ln -s ag2rs/iqtools iqtools
cd ag2rs
# Fetch and switch to branch we want to deploy
git fetch
git checkout jbs-geojson-h2
./gradlew clean build -x test
echo "Vantiq server should now be installed in /usr/share/ag2rs"

# Start H2 now
java -jar h2gis-standalone/h2-dist-1.2.3.jar &  

popd # /usr/share


