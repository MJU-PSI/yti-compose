#!/bin/bash
BRANCH=master

#Components list for publish
PUBLISH_COMPONENTS="
yti-spring-security:publishToMavenLocal
yti-spring-migration:publishToMavenLocal
yti-common-ui:npmBuild
"

#Components list for building
BUILD_COMPONENTS="
yti-docker-java-base
yti-postgres
yti-groupmanagement
yti-codelist-common-model
yti-codelist-public-api-service
yti-codelist-content-intake-service
yti-codelist-ui
yti-activemq
yti-terminology-termed-docker
yti-terminology-api
yti-terminology-ui
yti-fuseki
yti-datamodel-api
yti-datamodel-ui
yti-comments-api
yti-comments-ui
yti-messaging-api
"

publish_component () {
    pushd . > /dev/null
    echo "publish component:$1"
    echo "--------------------------"
    cd $BUILD_BASE/$1/
    echo $PWD
    ./gradlew $2
    echo "DONE $1"
    popd
}

build_component () {
    pushd . >/dev/null
    echo "--------------------------" 
    echo "build component:$1 option:$2"
    echo "--------------------------" 
    cd $BUILD_BASE/$1/
    ./build.sh $2
    popd
}

echo "Starting development environment Setup" 
if [ $# -eq 1 ]
  then
      echo "Active branch $1"
      BRANCH=$1
  else
    BRANCH=master
fi
BUILD_BASE=$PWD/build.$BRANCH

#Build generic artifacts
for component in $PUBLISH_COMPONENTS
do
    comp=$(echo $component | cut -f1 -d:)
    task=$(echo $component | cut -f2 -s -d:)
    publish_component $comp $task
done

#Build release and YTI containers
for component in $BUILD_COMPONENTS
do
    build_component $component
done
echo "YTI setup done" 
