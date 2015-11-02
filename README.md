# Introduction

Dockerfile to build a ActiveMQ container image.  This sits upon Apache Karaf, has integrated Apache Qpid (for AMQP) and Apache Camel inside the Message Broker (for flexible messaging), and thus gives multi-protocol, multi-language support (out of the box.

A-MQ is embeddable and highly available.  Currently this image acts as a stand-alone container in single-node availability.

# Hardware Requirements

## Memory

- **1GB** is the **standard** memory size. You should up that for production according to your needs.

## Storage

- Mostly, ActiveMQ stores things in memory, so no space is needed.  Should you start to persist to disk, consider attaching a data volume.

# How to Build a new Version

* Download JBoss A-MQ from http://www.jboss.org/products/amq/download/
* Put the file in the "install_files" directory
* Update the VERSION file
* run `batch.sh`

# Installation

Pull the image from the docker index. This is the recommended method of installation as it is easier to update image. These builds are performed by the **Docker Trusted Build** service.

```bash
docker pull jlgrock/activemq:$VERSION
```

Alternately you can build the image locally using the `build.sh` command


# Example Containers

```bash
docker run -it --rm -p 8101:8101 -p 8181:8181 -p 44444:44444 -p 1099:1099 -p 61616:61616 jlgrock/jboss-amq:6.2.0
```