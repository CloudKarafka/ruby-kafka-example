require 'bundler/setup'
require 'rdkafka'
require 'pp'

brokers = ENV['CLOUDKARAFKA_BROKERS']

config = {
          :"bootstrap.servers" => brokers,
          :"group.id"          => "cloudkarafka-example",
          :"sasl.username"     => ENV['CLOUDKARAFKA_USERNAME'],
          :"sasl.password"     => ENV['CLOUDKARAFKA_PASSWORD'],
          :"security.protocol" => "SASL_SSL",
          :"sasl.mechanisms"   => "SCRAM-SHA-256"
}
topic = "#{ENV['CLOUDKARAFKA_TOPIC_PREFIX']}.test"

rdkafka = Rdkafka::Config.new(config)
consumer = rdkafka.consumer
consumer.subscribe(topic)

begin
  consumer.each do |message|
    puts "Message received: #{message}"
  end
rescue Rdkafka::RdkafkaError => e
  retry if e.is_partition_eof?
  raise
end
