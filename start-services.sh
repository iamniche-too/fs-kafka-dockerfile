#!/bin/bash
set -e

echo $0 $1

if [ "$1" = 'zookeeper' ]; then
    echo "Running Zookeeper..."
    cd /opt/kafka && ./bin/zookeeper-server-start.sh config/zookeeper.properties
fi

if [ "$1" = 'kafka' ]; then
    echo "Running Kafka..."
    cd /opt/kafka && ./bin/kafka-server-start.sh config/server.properties
fi

if [ "$1" = 'topic' ]; then
    echo "Creating topic..."
    cd /opt/kafka && ./bin/kafka-topics.sh --create --bootstrap-server localhost:9092 --replication-factor 1 --partitions 1 --topic test 
fi

