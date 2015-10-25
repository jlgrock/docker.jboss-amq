FROM jlgrock/centos-oraclejdk:6.6-8u45
MAINTAINER Justin Grant <jlgrock@gmail.com>

ENV AMQ_PARENT /opt/jboss
ENV AMQ_HOME $AMQ_PARENT/jboss-a-mq

ADD install_files/ $AMQ_PARENT/
ADD VERSION $AMQ_PARENT/VERSION
ADD loadenv.sh $AMQ_PARENT/loadenv.sh

WORKDIR $AMQ_PARENT
RUN ./install.sh
ADD install_files/init.sh $AMQ_HOME/init.sh

### Create A-MQ User
RUN sed -i "s/#admin/admin/" $AMQ_HOME/etc/users.properties && \
	sed -i "s/#activemq.jmx.user/activemq.jmx.user/" $AMQ_HOME/etc/system.properties && \
	sed -i "s/#activemq.jmx.password/activemq.jmx.password/" $AMQ_HOME/etc/system.properties

### Open Ports
# SSH, Karaf-ssh, Web, rmiServerPort, rmiRegistry, ActiveMQ
EXPOSE 22 8101 8181 44444 1099 61616 

### Start A-MQ
ENTRYPOINT $AMQ_HOME/init.sh
