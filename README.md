# Introduction

Dockerfile to build a JBoss ActiveMQ container image.  This sits upon Apache Karaf, has integrated Apache Qpid (for AMQP) and Apache Camel inside the Message Broker (for flexible messaging), and thus gives multi-protocol, multi-language support (out of the box).

A-MQ is embeddable and highly available.  Currently this image acts as a stand-alone container in single-node availability.

# Hardware Requirements

## Memory

- **1GB** is the **standard** memory size. You should up that for production according to your needs.

## Storage

- Mostly, ActiveMQ stores things in memory, so no space is needed.  Should you start to persist to disk, consider attaching a data volume.

# How to get the image

## Option 1: Download from a Docker Registry

These builds are not performed by the **Docker Trusted Build** service because it contains proprietary code, but this method can be used if using a Private Docker Registry.

```bash
docker pull <private_registry_name>/jlgrock/jboss-eap:${VERSION}
```

## Option 2: Building the Image

* [Download JBoss AMQ 7.3.0](http://www.jboss.org/products/eap/download/)
* Put the file in the `install_files` directory
* Update the VERSION file
* run `build.sh`


## Parameters

Below is a complete list of available options that can be used to start JBoss AMQ with SSL.
* **BROKER_NAME**: defines the list of the names of the queue to create.  If a names are not provided, it will create a default queue called `amq`s
* **SSL**: accepts `true` or `false`.  `true` starts JBoss AMQ with SSL, using the SSL keystore and truststore provided (see SSL configuration section).  By default, this is set to `false`.
* **CLIENT_USERNAME**: The username used by the client to access the broker.  By default the username is `amq`.
* **CLIENT_PASSWORD**: The password used by the client to access the broker.  By default the password is `amq123!`.
* **KEYSTORE_PASSWORD**: The password used for the Keystore.  Required if `SSL=true`.
* **TRUSTSTORE_PASSWORD**:  The password used for the Truststore.  Required if `SSL=true`.

## SSL Configuration

When starting JBoss AMQ with SSL the following files must be present:
* **/amq/store/broker/broker.ks**: Broker KeyStore file
* **/amq/store/broker/broker.ts**: Broker TrustStore file

# Examples of Running a Container

The following will map only UI ports exposed
```bash
docker run -it --rm -p 8161:8161 jlgrock/jboss-amq:${VERSION}
```

The following will map all exposed ports
```bash
docker run -it --rm -p 8161:8161 -p61616:61616 jlgrock/jboss-amq:${VERSION}
```

The following will start JBoss AMQ with SSL (with only the UI exposed)
```bash
docker run -it --rm -p 8161:8161 -e SSL=true jlgrock/jboss-amq:${VERSION}
```

At which point you can access 
