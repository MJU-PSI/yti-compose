#!/bin/bash

GIT_REPO="https://github.com/MJU-PSI/"

#Component list
#Define gradle task with suffix <:publishToMavenLocal>
COMPONENTS="
yti-spring-security:publishToMavenLocal
yti-spring-migration:publishToMavenLocal
yti-common-ui:publishTarball
yti-codelist-common-model
yti-docker-java-base
yti-config-server
yti-codelist-public-api-service
yti-codelist-content-intake-service
yti-codelist-ui
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
"

#clone given repository from git with given branch or master
clone_component_from_git () {
    echo "Fetching $1$2"
    `git clone $1$2.git -b$3`
}

publish_component () {
    cd $1
    echo "Publishing $1 with task $2"
    ./gradlew $2
    cd ..
}
#Main
#Where to fetch sources
BRANCH=master
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
echo "Get components"
for component in $COMPONENTS
do
    repo=$(echo $component | cut -f1 -d:)
    task=$(echo $component | cut -f2 -s -d:)
    clone_component_from_git $GIT_REPO $repo $BRANCH

    if [ -n "$task" ]
    then
        echo "task=$task"
        publish_component $repo $task
    fi
done
cd ..
