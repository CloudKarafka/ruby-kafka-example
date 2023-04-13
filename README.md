# Ruby example for CloudKarafka

Simple example on how to use ruby and [rdkafka-ruby](https://github.com/appsignal/rdkafka-ruby) to produce and consume messages on a CloudKarafka Instance

## Setup and run

First, install rdkafka gem `gem install rdkafka`

To configure the consumer and producer to use your credentials this example uses environment variables.
An easy way to handle these is using `dotenv` and store all variables in a `.env` file like so:

```
CLOUDKARAFKA_HOSTNAME=rocket.srvs.cloudkafka.com
CLOUDKARAFKA_USERNAME=username
CLOUDKARAFKA_PASSWORD=password
```
and then you run the scripts like this:

`dotenv ruby producer.rb` or `dotenv ruby consumer.rb`

`dotenv` will read the `.env` file and set these as environment variables for the ruby process
