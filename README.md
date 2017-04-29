# docker-kafka

Dockerfile for [Apache Kafka](https://kafka.apache.org/)

Docker images built from this Dockerfile are available from
[Docker Hub](https://hub.docker.com/r/b9company/kafka/)

## Usage

```
docker run -ti b9company/kafka:2.12-0.10.2.1
```

## Image Information

### Volumes

The Docker image comes with one volume which Kafka uses for storing message
logs.

| Volume           | Description |
| ---------------- | ----------- |
| `/var/log/kafka` | `log.dirs` configuration parameter. Location where Kafka writes the message logs. |

## Build Notes

The Docker image can be tailored through variables during the build process.
Note that `SCALA_VERSION` and `KAFKA_VERSION` are required variables in order
to specify which Kafka version to build.

| Build-time Variable | Description |
| ------------------- | ----------- |
| `SCALA_VERSION`     | **Mandatory**. Scala version to build. |
| `KAFKA_VERSION`     | **Mandatory**. Kafka version to build. |
| `KAFKA_MIRROR`      | *Optional*. Mirror to use to download Kafka. |
| `KAFKA_ARCHIVE`     | *Optional*. URL to the Kafka tarball. In such case, `KAFKA_MIRROR` is ignored. |
| `KAFKA_LOGDIRS`      | *Optional*. `log.dirs` configuration parameter. |

To build `b9company/kafka:2.12-0.10.2.1` Docker image, run:

```
make build SCALA_VERSION=2.12 KAFKA_VERSION=0.10.2.1
```
