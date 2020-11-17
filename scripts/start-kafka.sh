#! /bin/bash

confluent start

kafka-topics --zookeeper localhost:2181 --delete --topic test-1

kafka-topics --create --zookeeper localhost:2181  --partitions 6 --replication-factor 1 --topic test-1

kafka-run-class kafka.tools.GetOffsetShell --broker-list localhost:9092 --topic test-1

