FROM infrabricks/ex-java:jre-8
MAINTAINER Peter Rossbach <peter.rossbach@bee42.com>

ENV TOMCAT_MINOR_VERSION 8.0.15
ENV CATALINA_HOME /opt/tomcat

RUN curl -O http://archive.apache.org/dist/tomcat/tomcat-8/v${TOMCAT_MINOR_VERSION}/bin/apache-tomcat-${TOMCAT_MINOR_VERSION}.tar.gz && \
  curl http://archive.apache.org/dist/tomcat/tomcat-8/v${TOMCAT_MINOR_VERSION}/bin/apache-tomcat-${TOMCAT_MINOR_VERSION}.tar.gz.md5 | md5sum -c - && \
  gunzip apache-tomcat-*.tar.gz && \
  tar xf apache-tomcat-*.tar && \
  rm apache-tomcat-*.tar && mv apache-tomcat* ${CATALINA_HOME} && \
  rm -rf ${CATALINA_HOME}/webapps/examples \
  ${CATALINA_HOME}/webapps/docs ${CATALINA_HOME}/webapps/ROOT \
  ${CATALINA_HOME}/webapps/host-manager \
  ${CATALINA_HOME}/RELEASE-NOTES ${CATALINA_HOME}/RUNNING.txt \
  ${CATALINA_HOME}/bin/*.bat ${CATALINA_HOME}/bin/*.tar.gz

WORKDIR /opt/tomcat
EXPOSE 8080
EXPOSE 8009

ADD LICENSE /etc/LICENSE.tomcat

RUN COPYDATE=`date  +'%Y'` && echo "infrabricks tomcat" >/etc/provisioned.tomcat && date >>/etc/provisioned.tomcat && echo >>/etc/provisioned.tomcat && echo " Copyright ${COPYDATE} by <peter.rossbach@bee42.com> bee42 solutions gmbh" >>/etc/provisioned.tomcat

ENTRYPOINT ["/opt/tomcat/bin/catalina.sh"]
CMD [ "run" ]
