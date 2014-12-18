FROM progrium/busybox
MAINTAINER Peter Rossbach <peter.rossbach@bee42.com>

# Install cURL
RUN opkg-install curl

# Java Version
ENV JAVA_VERSION_MAJOR 8
ENV JAVA_VERSION_MINOR 25
ENV JAVA_VERSION_BUILD 17
ENV JAVA_PACKAGE       jdk
ENV JAVA_CHECKSUM      e145c03a7edc845215092786bcfba77e

# Download and unarchive Java
RUN curl -kLOH "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" \
http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-b${JAVA_VERSION_BUILD}/${JAVA_PACKAGE}-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.tar.gz \
  && echo "${JAVA_CHECKSUM}  ${JAVA_PACKAGE}-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.tar.gz" > ${JAVA_PACKAGE}-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.tar.gz.md5.txt \
  && md5sum -c ${JAVA_PACKAGE}-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.tar.gz.md5.txt \
  && gunzip ${JAVA_PACKAGE}-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.tar.gz \
  && tar -xf ${JAVA_PACKAGE}-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.tar -C /opt \
  && rm ${JAVA_PACKAGE}-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.tar* \
  && ln -s /opt/jdk1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR} /opt/jdk

# Set environment
ENV JAVA_HOME /opt/jdk
ENV PATH ${PATH}:${JAVA_HOME}/bin

VOLUME [ "/opt/jdk1.8.0_25"]

ENTRYPOINT ["java"]
CMD ["-version"]

ADD LICENSE /etc/LICENSE.java
ADD LICENSE.oracle /etc/LICENSE.oracle

RUN COPYDATE=`date  +'%Y'` && echo "infrabricks java" >/etc/provisioned.java && date >>/etc/provisioned.java && echo >>/etc/provisioned.java && echo " Copyright ${COPYDATE} by <peter.rossbach@bee42.com> bee42 solutions gmbh" >>/etc/provisioned.java
