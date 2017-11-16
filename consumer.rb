require 'kafka'

# Create an array with the broker host names.
brokers = ENV['CLOUDKARAFKA_BROKERS'].split(',')

kafka = Kafka.new(seed_brokers: brokers,
                  ssl_ca_cert: File.read('ca.pem'),
                  sasl_scram_username: ENV['CLOUDKARAFKA_USERNAME'],
                  sasl_scram_password: ENV['CLOUDKARAFKA_PASSWORD'],
                  sasl_scram_mechanism: 'sha256')

consumer = kafka.consumer(group_id: "cloudkarafka-example")

topic = "#{ENV['CLOUDKARAFKA_TOPIC_PREFIX']}.test"
consumer.subscribe(topic)

puts "Subscribed to topic: #{topic}"

# This will loop indefinitely, yielding each message in turn.
consumer.each_message do |message|
  puts "Topic: #{message.topic}, partition: #{message.partition}"
  puts "Offset: #{message.offset} #{message.key} #{message.value}"
end
