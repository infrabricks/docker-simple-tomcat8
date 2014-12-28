# Tomcat Application builder and executor

## This sample validate the idea


Start simple war delivery service `./testserver.sh`
At your env I hope you can use artifactory.

Build your sample folder

```
mkdir -p test
cd test
mkdir -p webapps lib conf
vi test.warset
vi conf/tomcat-users.xml
```

**test.warset**

```
a http://192.168.59.103:9000/testwars/a.war
b http://192.168.59.103:9000/testwars/b.war
```

**conf/tomcat-users.xml**

```xml
<?xml version='1.0' encoding='utf-8'?>
<tomcat-users xmlns="http://tomcat.apache.org/xml"
xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
xsi:schemaLocation="http://tomcat.apache.org/xml tomcat-users.xsd"
version="1.0">
<role rolename="manager-script"/>
<role rolename="manager-gui"/>
<user username="manager" password="tomcat" roles="manager-script,manager-gui"/>
</tomcat-users>
```

build your war data container

```bash
$ echo -e "FROM infrabricks/ex-warset\n\r" >Dockerfile
$ cat test.warset |../download.sh
$ ls webapps/
a.war	b.war
$ docker build -t="infrabricks/ex-test" .
Sending build context to Docker daemon 8.192 kB
Sending build context to Docker daemon
Step 0 : FROM infrabricks/ex-warset
# Executing 3 build triggers
Trigger 0, ADD webapps/ /opt/bootstrap/webapps
Step 0 : ADD webapps/ /opt/bootstrap/webapps
Trigger 1, ADD lib/ /opt/bootstrap/lib
Step 0 : ADD lib/ /opt/bootstrap/lib
Trigger 2, ADD conf/ /opt/bootstrap/conf
Step 0 : ADD conf/ /opt/bootstrap/conf
---> efb0e643a6ac
Removing intermediate container 5093dd6a9c18
Removing intermediate container 5b11f918ec26
Removing intermediate container 9b7506187d12
Successfully built efb0e643a6ac
```

Run your wars at tomcat

```
$ docker run --name testwar infrabricks/ex-test
infrabricks webapps
Sat Dec 27 06:17:13 UTC 2014

Copyright 2014 by <peter.rossbach@bee42.com> bee42 solutions gmbh
$ ../run.sh testwar
Find your tomcat at following host 172.17.0.7
8080/tcp -> 0.0.0.0:8090
$ curl -su manager:tomcat http://192.168.59.103:8090/manager/text/list
OK - Listed applications for virtual host localhost
/a:running:0:a
/b:running:0:b
/manager:running:0:manager
$ curl -s http://192.168.59.103:8090/a/index.html
hello a
```

**That so simple, but a shell hack!**

---

## Create a real Tomcat Builder Tool or use maven/gradle plugins!

 - implement with go
 - use a tomcat build dsl
 - build on this base images
   - infrabricks/ex-tomcat
     - tomcat runtime
   - infrabricks/ex-tomcat-executor
     - on build tool
     - install a new dir with sample
       ```
       alias te-gen="docker run --rm infrabricks/ex-tomcat-executor generator"
       te-gen sample
       ```
     - have install generator at your bash
       - `docker run --rm -v ~/.bash_profile:/profile infrabricks/ex-tomcat-executor install && source ~/.bash_profile`
       - see commands `te help`

### Tomcat warset build format (pre alpha)

```yaml
app:
  name: infrabricks/ex-test
  tags:
    latest?
    branch name?
    %date -format
    0.0.1
    git revision?
  license: file
  webapps:
    a:
      url: http://192.168.59.103:9000/testwars/a.war
      checksum: sss
      extract: yes/no (default yes)
  libs:
    mysql
    libs:
      mysql:
        url: https://artifactory...
        checksum: xxx
server:
  dev:
    image: infrabricks/ex-tomcat:8
    env:
      key1: value
      key2: value
    envfile: test-dev.conf
  prod:
    image: infrabricks/ex-tomcat:8
    envfile: test-dev.conf
    ports:
      "8080:8080"
      "8009"
```

### Comments....

 - Configurations are directly setup at build conf directory
 - extract war reduce start time at tomcat
 - spezial context.xml setup META-INF/context.xml at your war's
 - Use properties to customize your configs
   - _TODO_: include a spezial property env replacer...  
 - Server section is to run the app
   - check if data app container exists
   - if app no exits pull it, build a datacontainer, run server on it
   - if app is not at your registry, then build it locally, ...
   - have an option to destroy existing data container
   - have an option to rebuild it
 - Generate a fig or docker composer config
 - Logging Volume?
 - install tool aliases direct from image:)
 - HOW this work with docker-maven-plugins?
   - roland huss
   - wouterd
 - HTTP(S) Autorisation
   - Basic
   - Client Certs
   - OAuth  
 - generate a builder document
   - Like META-INF/manifest.mf
     - List of URL'S
     - checksum
     - Author
