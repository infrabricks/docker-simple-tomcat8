FROM progrium/busybox
MAINTAINER Peter Rossbach <peter.rossbach@bee42.com>

RUN mkdir -p /opt/bootstrap/webapps /opt/bootstrap/conf /opt/bootstrap/lib /opt/bootstrap/bin
ADD bin/tomcat.sh /opt/bootstrap/bin/tomcat.sh

ONBUILD ADD webapps/ /opt/bootstrap/webapps
ONBUILD ADD lib/ /opt/bootstrap/lib
ONBUILD ADD conf/ /opt/bootstrap/conf

VOLUME [ "/opt/bootstrap"]

ADD LICENSE /etc/LICENSE.webapps

RUN COPYDATE=`date  +'%Y'` && echo "infrabricks webapps" >/etc/provisioned.webapps && date >>/etc/provisioned.webapps && echo >>/etc/provisioned.webapps && echo " Copyright ${COPYDATE} by <peter.rossbach@bee42.com> bee42 solutions gmbh" >>/etc/provisioned.webapps

ENTRYPOINT ["/bin/cat"]
CMD [ "/etc/provisioned.webapps" ]
