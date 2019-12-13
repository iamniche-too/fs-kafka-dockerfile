FROM ubuntu:18.04 

# default to bash shell
#SHELL ["/bin/bash", "-c"]

ARG kafka_version=2.3.0
ARG scala_version=2.12

LABEL org.label-schema.name="kafka" \
      org.label-schema.description="Apache Kafka" \
      org.label-schema.build-date="${build_date}" \
      org.label-schema.version="${scala_version}_${kafka_version}" \
      org.label-schema.schema-version="1.0"

RUN apt-get update && apt-get install --assume-yes openjdk-8-jre-headless \
    ssh-client \
    docker.io \
    wget \
    git

ENV KAFKA_VERSION=$kafka_version \
    SCALA_VERSION=$scala_version \
    KAFKA_HOME=/opt/kafka \
    DIRECTORY=kafka_$scala_version-$kafka_version \
    FILENAME=kafka_$scala_version-$kafka_version.tgz

ENV PATH=${PATH}:${KAFKA_HOME}/bin

RUN wget http://mirror.vorboss.net/apache/kafka/$KAFKA_VERSION/$FILENAME -O /tmp/$FILENAME
RUN tar -xf /tmp/$FILENAME -C /opt

#Note - will be unpacked
#ADD $FILENAME /opt

# symlink to /opt/kafka
RUN ln -s /opt/$DIRECTORY ${KAFKA_HOME}

COPY start-services.sh /tmp 
RUN chmod a+x /tmp/*.sh
RUN cp /tmp/start-services.sh /usr/bin

VOLUME ["/kafka"]

ENTRYPOINT ["/bin/bash", "/usr/bin/start-services.sh"]
