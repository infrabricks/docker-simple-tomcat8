#!/bin/sh

DIR=${DEPLOY_DIR:-/opt/bootstrap/webapps}
echo "Checking *.war in $DIR"
if [ -d $DIR ]; then
  for i in $DIR/*.war; do
    if [ -f $i ]; then
      file=$(basename $i)
      echo "Linking $i --> ${CATALINA_HOME}/webapps/$file"
      ln -sf $i ${CATALINA_HOME}/webapps/$file
    fi
  done
fi

DIR=${LIB_DIR:-/opt/bootstrap/lib}
echo "Checking tomcat extended libs *.jar in $DIR"
if [ -d $DIR ]; then
  for i in $DIR/*.jar; do
    if [ -f $i ]; then
      file=$(basename $i)
      echo "Linking $i --> ${CATALINA_HOME}/lib/$file"
      ln -sf $i ${CATALINA_HOME}/lib/$file
    fi
  done
fi

DIR=${CONF_DIR:-/opt/bootstrap/conf}
echo "Checking tomcat conf files in $DIR"
if [ -d $DIR ]; then
  for i in $DIR/*.properties $DIR/*.xml $DIR/*.policy; do
    if [ -f $i ]; then
      file=$(basename $i)
      echo "Linking $i --> ${CATALINA_HOME}/conf/$file"
      ln -sf $i ${CATALINA_HOME}/conf/$file
    fi
  done
fi

# Autorestart possible?
#-XX:OnError="cmd args; cmd args"
#-XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/tmp/heapdump.hprof -XX:OnOutOfMemoryError="sh ~/cleanup.sh"

export LANG="en_US.UTF-8"
export JAVA_OPTS="$JAVA_OPTS -Duser.language=en -Duser.country=US"
export CATALINA_PID=${CATALINA_HOME}/temp/tomcat.pid
export CATALINA_OPTS="$CATALINA_OPTS -Xmx512m\
 -Djava.security.egd=file:/dev/./urandom"
${CATALINA_HOME}/bin/catalina.sh run
