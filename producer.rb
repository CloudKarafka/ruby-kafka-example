require "rdkafka"

username = ENV.fetch("CLOUDKARAFKA_USERNAME")
password = ENV.fetch("CLOUDKARAFKA_PASSWORD")
hostname = ENV.fetch("CLOUDKARAFKA_HOSTNAME")
brokers = "#{hostname}:9094"
topic = "#{username}-default"

rdkafka = Rdkafka::Config.new(
  "bootstrap.servers" => brokers,
  "sasl.username" => username,
  "sasl.password" => password,
  "security.protocol" => "SASL_SSL",
  "sasl.mechanisms" => "SCRAM-SHA-512"
)
producer = rdkafka.producer

puts "Producing 100 records to topic #{topic} on #{username}@#{brokers}"

msg_id = 0
batch_size = 100
loop do
  Array.new(batch_size).map do
    puts "Producing message #{msg_id}"
    payload = "My message #{msg_id}"
    key = "key-#{msg_id}"
    msg_id += 1
    producer.produce(topic:, payload:, key:)
  end.each(&:wait)
end
