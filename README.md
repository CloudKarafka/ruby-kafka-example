# Apache Kafka example for Ruby

## Setup

Make sure you have any modern version of Ruby up and running. 
Then install bundler and dependencies for this codebase.

```bash
cd ruby-kafka-example
gem install bundler && bundle
```

Create your account on [cloudkarafka], and set this environment variables:

```bash
export CLOUDKARAFKA_BROKERS=a....cloudkafka.com:9094,a....cloudkafka.com:9094,ar....cloudkafka.com:9094
export CLOUDKARAFKA_USERNAME=your-username
export CLOUDKARAFKA_PASSWORD=your-password
export CLOUDKARAFKA_TOPIC_PREFIX=topic_prefix-
```

Visit Dashboard on [cloudkarafka] and create a topic with name similar to this `topic_prefix-test`.


Bootup the [consumer.rb](consumer.rb)

```bash
ruby consumer.rb
```

Then run the [producer.rb](producer.rb) that will generate some messages:

```bash
ruby producer.rb
```

And you sould be good to go with your experiments.

Fin.


[cloudkarafka]:https://www.cloudkarafka.com/
