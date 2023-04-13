require "rdkafka"

username = ENV.fetch("CLOUDKARAFKA_USERNAME")
password = ENV.fetch("CLOUDKARAFKA_PASSWORD")
hostname = ENV.fetch("CLOUDKARAFKA_HOSTNAME")
brokers = "#{hostname}:9094"
group_id = "#{username}-testing4"
topic = "#{username}-default"

rdkafka = Rdkafka::Config.new(
  "bootstrap.servers" => brokers,
  "group.id" => group_id,
  "sasl.username" => username,
  "sasl.password" => password,
  "security.protocol" => "SASL_SSL",
  "sasl.mechanisms" => "SCRAM-SHA-512",
  "client.id": "ruby-rdkafka"
)
consumer = rdkafka.consumer
consumer.subscribe(topic)

puts "Consuming topic #{topic} from #{username}@#{brokers}..."

begin
  consumer.each do |msg|
    puts "[#{msg.topic}-#{msg.partition}] offset=#{msg.offset} key='#{msg.key}' payload='#{msg.payload}'"
  end
rescue Rdkafka::RdkafkaError => e
  retry if e.is_partition_eof?
  raise
end
