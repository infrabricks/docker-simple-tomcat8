# OpenJDK Java 8 JDK Dockerfile
FROM debian:7.7
MAINTAINER Peter Rossbach <peter.rossbach@bee42.com>

ENV DEBIAN_FRONTEND noninteractive
ENV JAVAVERSION 8

# Install Java.
RUN echo "deb http://ftp.us.debian.org/debian sid main" >> /etc/apt/sources.list \
  && apt-get update -q \
  && apt-get install -qy curl procps openjdk-${JAVAVERSION}-jdk \
  && ln -s /usr/lib/jvm/java-${JAVAVERSION}-openjdk-amd64 /opt/jdk \
  && rm -rf /var/lib/{apt,dpkg,cache,log,lists}/

# Set environment
ENV JAVA_HOME /opt/jdk
ENV PATH ${PATH}:${JAVA_HOME}/bin

ENTRYPOINT ["java"]
CMD ["-version"]

ADD LICENSE /etc/LICENSE.java

RUN COPYDATE=`date  +'%Y'` && echo "infrabricks java" >/etc/provisioned.java && date >>/etc/provisioned.java && echo >>/etc/provisioned.java && echo " Copyright ${COPYDATE} by <peter.rossbach@bee42.com> bee42 solutions gmbh" >>/etc/provisioned.java
