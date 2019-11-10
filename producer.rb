require 'bundler/setup'
require 'rdkafka'

config = {
          :"bootstrap.servers" => ENV.fetch('CLOUDKARAFKA_BROKERS'),
          :"group.id"          => "cloudkarafka-example",
          :"sasl.username"     => ENV.fetch('CLOUDKARAFKA_USERNAME'),
          :"sasl.password"     => ENV.fetch('CLOUDKARAFKA_PASSWORD'),
          :"security.protocol" => "SASL_SSL",
          :"sasl.mechanisms"   => "SCRAM-SHA-256"
}
topic = "#{ENV['CLOUDKARAFKA_TOPIC_PREFIX']}test"

rdkafka = Rdkafka::Config.new(config)
producer = rdkafka.producer

1000.times do |i|
  puts "Producing message #{i}"
  producer.produce(
      topic:   topic,
      payload: "This is my payload #{i} TEST 2",
      key:     "Key #{i}"
  ).wait
end
