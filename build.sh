#!/bin/bash
docker build -t="infrabricks/ex-java:jre-8"        <Dockerfile.jre8
docker build -t="infrabricks/ex-java:jdk-8"        <Dockerfile.jdk8
docker build -t="infrabricks/ex-tomcat:8"          <Dockerfile.tomcat8
docker build -t="infrabricks/ex-tomcat:8-volume"   <Dockerfile.tomcat8-volume
cd webapp/status
zip -r ../../status.war .
cd ../..
docker build -t="infrabricks/ex-status"            <Dockerfile.status
