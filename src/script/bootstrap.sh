#!/bin/bash
BRANCH=master
GIT_REPO="https://github.com/MJU-PSI/"

#Component list
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

#clone given repository from git with given branch or master
clone_component_from_git () {
    echo "Fetching $1$2"
    `git clone $1$2.git -b$3`
}

#Main
#Where to fetch sources
if [ $# -eq 1 ]
  then
      echo "Active branch $1"
      BRANCH=$1
fi
BUILD_BASE=$PWD/build.$BRANCH

echo "Clone repositories"
mkdir -p $BUILD_BASE
cd $BUILD_BASE
echo "Fetching components into the $BUILD_BASE"
for component in $COMPONENTS
do
    clone_component_from_git $GIT_REPO $component $BRANCH
done
cd ..
echo "YTI bootstrap done" 
