require 'kafka'

# Create an array with the broker host names.
brokers = ENV['CLOUDKARAFKA_BROKERS'].split(',')

kafka = Kafka.new(seed_brokers: brokers,
                  ssl_ca_cert: File.read('ca.pem'),
                  sasl_scram_username: ENV['CLOUDKARAFKA_USERNAME'],
                  sasl_scram_password: ENV['CLOUDKARAFKA_PASSWORD'],
                  sasl_scram_mechanism: 'sha256')
producer = kafka.producer
topic = "#{ENV['CLOUDKARAFKA_TOPIC_PREFIX']}.test"

i = 0
loop do
  msg = "Hello from Ruby #{i}"
  producer.produce(msg, topic: topic)

  # If this line fails with Kafka::DeliveryFailed we *may* have succeeded in delivering
  # the message to Kafka but won't know for sure.
  producer.deliver_messages
  # If we get to this line we can be sure that the message has been delivered to Kafka!
  i += 1
  sleep 1
end
