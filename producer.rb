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
producer = rdkafka.producer

100.times do |i|
  puts "Producing message #{i}"
  producer.produce(
      topic:   topic,
      payload: "Payload #{i}",
      key:     "Key #{i}"
  ).wait
end
