FROM progrium/busybox
MAINTAINER Peter Rossbach <peter.rossbach@bee42.com>

RUN mkdir -p /opt/tomcat/webapps
ADD status.war /opt/tomcat/webapps/status.war

ADD LICENSE /etc/LICENSE.status

RUN COPYDATE=`date  +'%Y'` && echo "infrabricks status" >/etc/provisioned.status && date >>/etc/provisioned.status && echo >>/etc/provisioned.status && echo " Copyright ${COPYDATE} by <peter.rossbach@bee42.com> bee42 solutions gmbh" >>/etc/provisioned.status

ENTRYPOINT ["/bin/cat"]
CMD [ "/etc/provisioned.status" ]
