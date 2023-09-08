#!/bin/bash
#
#
#----------------------------------
docker exec $(docker ps -q -f name=yti-postgres) psql -U postgres -d yti_groupmanagement -c "INSERT INTO user VALUES ('admin@localhost','Admin','User',true,null,null,'4ce70937-6fa4-49af-a229-b5f10328adb8')"
#----------------------------------
#----------------------------------
docker exec $(docker ps -q -f name=yti-postgres) psql -U postgres -d yti_groupmanagement -c "INSERT INTO organization (id,url) VALUES ('7d3a3c00-5a6b-489b-a3ed-63bb58c26a63','https://yhteentoimiva.suomi.fi/')"
#----------------------------------
#----------------------------------
docker exec $(docker ps -q -f name=yti-postgres) psql -U postgres -d yti_groupmanagement -c "INSERT INTO organization_trans (organization_id,language,name) VALUES ('7d3a3c00-5a6b-489b-a3ed-63bb58c26a63','en','Interoperability platform developers')"
docker exec $(docker ps -q -f name=yti-postgres) psql -U postgres -d yti_groupmanagement -c "INSERT INTO organization_trans (organization_id,language,name) VALUES ('7d3a3c00-5a6b-489b-a3ed-63bb58c26a63','sl','Razvijalci platforme za semantično interoperabilnost')"
#----------------------------------
#----------------------------------
docker exec $(docker ps -q -f name=yti-postgres) psql -U postgres -d yti_groupmanagement -c "INSERT INTO user_organization VALUES ('7d3a3c00-5a6b-489b-a3ed-63bb58c26a63','ADMIN','4ce70937-6fa4-49af-a229-b5f10328adb8')"
#----------------------------------
