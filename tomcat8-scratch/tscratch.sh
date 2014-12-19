#!/bin/bash
if [ "${1}z" != "z" ]; then
  T_V=$1
fi
if [ "${T_V}z" == "z" ]; then
  T_V=8.0.15
fi

if [ ! -d "apache-tomcat-${T_V}" ]; then
  echo "Download apache-tomcat-${T_V}"
  T_URL=http://archive.apache.org/dist/tomcat/tomcat-8
  curl -O ${T_URL}/v${T_V}/bin/apache-tomcat-${T_V}.tar.gz
  tar xzf apache-tomcat-${T_V}.tar.gz
fi

docker run -d -p 8080 \
 -v `pwd`/apache-tomcat-${T_V}:/opt/tomcat \
 -v `pwd`/../status/webapp:/opt/tomcat/webapps/status \
  --entrypoint /opt/tomcat/bin/catalina.sh \
 infrabricks/ex-java:jdk-8 run
CID=$(docker ps -lq)
IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' ${CID})
echo "Find your tomcat at following host $IP"
docker port $CID

