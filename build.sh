#!/bin/bash
docker build -t="infrabricks/ex-java:jre-8" jre8
docker build -t="infrabricks/ex-java:jdk-8" jdk8
docker build -t="infrabricks/ex-tomcat:8" tomcat8
docker build -t="infrabricks/ex-tomcat:8-volume" tomcat8-volume
cd status/webapp
zip -r ../status.war .
cd ../..
docker build -t="infrabricks/ex-status" status
