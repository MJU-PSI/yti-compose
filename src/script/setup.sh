#!/bin/bash
BRANCH=master
GIT_REPO="https://github.com/MJU-PSI/"

#Components list for publish
PUBLISH_COMPONENTS="
yti-spring-security:publishToMavenLocal
yti-spring-migration:publishToMavenLocal
yti-common-ui:npmBuild
"

#Components list for building
BUILD_COMPONENTS="
yti-termed-api
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
yti-keycloak
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

publish_component () {
    pushd . > /dev/null
    echo "Publishing $1 with task $2"
    cd $BUILD_BASE/$1/
    echo $PWD
    ./gradlew $2
    echo "DONE $1"
    popd
}

build_component () {
    pushd . >/dev/null
    echo "Building $1 with option $2"
    cd $BUILD_BASE/$1/
    echo $PWD
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

#Pull changes from GIT repository
COMPONENTS="${PUBLISH_COMPONENTS}${BUILD_COMPONENTS}"
#Build generic artifacts
for component in $COMPONENTS
do
    comp=$(echo $component | cut -f1 -d:)
    pull_component_from_git $comp
done

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
