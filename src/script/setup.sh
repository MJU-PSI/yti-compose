#!/bin/bash
BRANCH=master
GIT_REPO="https://github.com/MJU-PSI/"

#Components list
COMPONENTS="
yti-docker-java-base
yti-spring-security
yti-spring-migration
yti-common-ui
yti-codelist-common-model
yti-codelist-public-api-service
yti-codelist-content-intake-service
yti-codelist-ui
yti-termed-api
yti-terminology-termed-docker
yti-terminology-api
yti-terminology-ui
yti-fuseki
yti-datamodel-api
yti-datamodel-ui
yti-groupmanagement
yti-comments-api
yti-comments-ui
yti-messaging-api
yti-activemq
yti-postgres
yti-keycloak
yti-elasticsearch
"

pull_component_from_git () {
    pushd . > /dev/null
    echo "Pulling $1"
    cd $BUILD_BASE/$1/
    echo $PWD
    git pull
    echo "DONE $1"
    popd
}

build_component () {
    pushd . >/dev/null
    echo "Building $1"
    cd $BUILD_BASE/$1/
    echo $PWD
    ./build.sh
    popd
}

echo "Starting environment Setup" 
if [ $# -eq 1 ]
  then
      echo "Active branch $1"
      BRANCH=$1
  else
    BRANCH=master
fi
BUILD_BASE=$PWD/build.$BRANCH

#Run build script
for component in $COMPONENTS
do
    pull_component_from_git $component
    build_component $component
done
echo "YTI setup done" 
