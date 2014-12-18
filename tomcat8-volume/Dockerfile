FROM progrium/busybox
MAINTAINER Peter Rossbach <peter.rossbach@bee42.com>

# Install wget
RUN opkg-install wget ca-certificates

ENV TOMCAT_MINOR_VERSION 8.0.15
ENV CATALINA_HOME /opt/tomcat

RUN wget -q https://archive.apache.org/dist/tomcat/tomcat-8/v${TOMCAT_MINOR_VERSION}/bin/apache-tomcat-${TOMCAT_MINOR_VERSION}.tar.gz && \
  wget -qO- https://archive.apache.org/dist/tomcat/tomcat-8/v${TOMCAT_MINOR_VERSION}/bin/apache-tomcat-${TOMCAT_MINOR_VERSION}.tar.gz.md5 | md5sum -c - && \
  gunzip apache-tomcat-*.tar.gz && \
  tar xf apache-tomcat-*.tar && \
  rm apache-tomcat-*.tar && mv apache-tomcat* ${CATALINA_HOME} && \
  rm -rf ${CATALINA_HOME}/webapps/examples \
  ${CATALINA_HOME}/webapps/docs ${CATALINA_HOME}/webapps/ROOT \
  ${CATALINA_HOME}/webapps/host-manager \
  ${CATALINA_HOME}/RELEASE-NOTES ${CATALINA_HOME}/RUNNING.txt \
  ${CATALINA_HOME}/bin/*.bat ${CATALINA_HOME}/bin/*.tar.gz

VOLUME [ "/opt/tomcat" ]
ADD LICENSE /etc/LICENSE.tomcat

RUN COPYDATE=`date  +'%Y'` && echo "infrabricks tomcat" >/etc/provisioned.tomcat && date >>/etc/provisioned.tomcat && echo >>/etc/provisioned.tomcat && echo " Copyright ${COPYDATE} by <peter.rossbach@bee42.com> bee42 solutions gmbh" >>/etc/provisioned.tomcat

ENTRYPOINT ["/bin/cat"]
CMD [ "/etc/provisioned.tomcat" ]
