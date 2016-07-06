FROM jlgrock/centos-oraclejdk:6.6-8u45
MAINTAINER Justin Grant <jlgrock@gmail.com>

ENV AMQ_PARENT /opt/jboss
ENV AMQ_HOME $AMQ_PARENT/jboss-a-mq

ADD install_files/ $AMQ_PARENT/
ADD resources/ $AMQ_PARENT/
ADD VERSION $AMQ_PARENT/VERSION
ADD loadenv.sh $AMQ_PARENT/loadenv.sh

WORKDIR $AMQ_PARENT
RUN chmod +x *.sh
RUN ./install.sh
RUN mv init.sh $AMQ_HOME/init.sh
RUN mv setup_ssl.sh $AMQ_HOME/setup_ssl.sh
RUN mv activemq_ssl.xml $AMQ_HOME/activemq_ssl.xml

### Create A-MQ User
RUN sed -i "s/#admin/admin/" $AMQ_HOME/etc/users.properties && \
	sed -i "s/#activemq.jmx.user/activemq.jmx.user/" $AMQ_HOME/etc/system.properties && \
	sed -i "s/#activemq.jmx.password/activemq.jmx.password/" $AMQ_HOME/etc/system.properties

### Open Ports
# SSH, Karaf-ssh, Web, rmiServerPort, rmiRegistry, ActiveMQ
EXPOSE 22 8101 8181 44444 1099 61616 

### Start A-MQ
ENTRYPOINT ["./jboss-a-mq/init.sh"]
CMD [""]
