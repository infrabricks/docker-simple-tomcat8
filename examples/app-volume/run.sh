#!/bin/bash
CID=$(docker run -d -p 8090:8080 \
 --volumes-from $1 \
 --entrypoint=/opt/bootstrap/bin/tomcat.sh \
infrabricks/ex-tomcat:8)
IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' ${CID})
echo "Find your tomcat at following host $IP"
docker port $CID
