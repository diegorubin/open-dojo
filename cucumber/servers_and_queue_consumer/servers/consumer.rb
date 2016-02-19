require "bunny"

conn = Bunny.new
conn.start

ch = conn.create_channel
q = ch.queue("dojo", :exclusive => true)

q.subscribe(:block => true, :manual_ack => true) do |delivery_info, properties, payload|
  name = properties[:headers]['name']
  puts name
  f = File.open("files/#{name}", 'w')
  f.puts payload
  f.close
end

