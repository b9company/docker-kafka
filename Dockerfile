FROM openjdk:8-jre

LABEL maintainer="the B9 Company <lab@b9company.fr>"

ARG KAFKA_VERSION
ARG SCALA_VERSION
ARG KAFKA_MIRROR="http://apache.crihan.fr/dist/kafka"
ARG KAFKA_ARCHIVE="${KAFKA_MIRROR}/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz"
ARG KAFKA_LOGDIRS="/var/log/kafka"

ENV KAFKA_HOME "/usr/local/kafka"

RUN ["/bin/bash", "-c", "set -o pipefail && wget -qO - \"${KAFKA_ARCHIVE}\" | tar zx -C /usr/local/"]
RUN ln -s `basename "${KAFKA_ARCHIVE}" .tgz` "${KAFKA_HOME}" && \
    sed -i "/^log.dirs=/c log.dirs=${KAFKA_LOGDIRS}" "${KAFKA_HOME}/config/server.properties"

ENV PATH "$PATH:${KAFKA_HOME}/bin"

WORKDIR "${KAFKA_HOME}"

VOLUME ["${KAFKA_LOGDIRS}"]

CMD ["sh", "-c", "bin/kafka-server-start.sh", "config/server.properties"]
