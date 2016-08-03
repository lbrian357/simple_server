require 'socket'

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
    client.print "HTTP/1.0 200 OK\r\n" + "Date: #{Time.now.ctime}\r\n" + "Content-Type: hash\r\n" + "Content-Length: \r\n"
    client.print "\r\n"
    client.print "#{File.read('./thanks.html')}"

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
