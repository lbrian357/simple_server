require 'socket'
require 'json'

server = TCPServer.open('localhost',2000)
loop {
  client = server.accept

  reqst = client.gets
  emails = {}
  if reqst.include?('/index.html')
    p 'includes /index.html is true'
    if File.exists?('./index.html')
      client.print "HTTP/1.0 200 OK\r\n" + "Date: #{Time.now.ctime}\r\n" + "Content-Type: text/html\r\n" + "Content-Length: #{File.open('./index.html').read.bytesize}\r\n"
      client.print "\r\n"
      client.print "#{File.read('./index.html')}"
    else
      client.print "HTTP/1.0 404 File not found\r\n" + "Date: #{Time.now.ctime}\r\n"
    end
  else
    p 'file to get does not include /index.html'

  end

  if reqst.include?('POST')
    p "includes POST"
    
    json_string = reqst.slice(/{.*}/)
    p "json_string is equal #{json_string}"
    params = {}
    params = params.merge(JSON.parse(json_string))
    p params.class
    p params['viking']['name']
    client.print "HTTP/1.0 200 OK\r\n" + "Date: #{Time.now.ctime}\r\n" + "Content-Type: JSON\r\n" + "Content-Length: #{json_string.bytesize}\r\n"
    client.print "\r\n"
f = File.read('./thanks.html')
string_to_replace = params['viking']['name']
fs= f.gsub("<%= yield %>", "<li>Name: #{params['viking']['name']}</li><li>Email: #{params['viking']['email']}</li>")
p fs
    client.print fs

  else 
    p 'request does not include POST'

  end
=begin
client.print 'asdf' 
  client.print(Time.now.ctime)
=end
  client.print 'Closing the connection. Bye!'
  client.close
  #  server.close 
}
