FROM jlgrock/centos-openjdk:6.6-8u221
MAINTAINER Justin Grant <jlgrock@gmail.com>

ENV AMQ_PARENT /opt/app/jboss
ENV AMQ_HOME $AMQ_PARENT/jboss-a-mq

ADD install_files/ $AMQ_PARENT/
ADD resources/ $AMQ_PARENT/
ADD VERSION $AMQ_PARENT/VERSION
ADD loadenv.sh $AMQ_PARENT/loadenv.sh

WORKDIR $AMQ_PARENT

# Install amq
RUN ./install.sh

RUN touch /var/lib/rpm/* && \
    yum install -y epel-release && \
    yum install -y xmlstarlet \
        unzip

### Open Ports
# SSH, UI, JMS-2.0, remoting port, AMQP Port, STOMP Port, HornetQ port
EXPOSE 22 8161 61616 61617 5673 61614 5446

### Start A-MQ
ENTRYPOINT ["./entrypoint.sh"]
CMD [""]
