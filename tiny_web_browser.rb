require 'socket'

class Browser
  attr_accessor :host, :port, :path, :emails
  def initialize
    @host = 'localhost'     # The web server
    @port = 2000  # Default HTTP port
    @path = ""                 # The file we want 
    @emails = {}
  end

  def request_choice
    print "do you want to 'GET' or 'POST'? "
    choice = gets.chomp
    if choice == 'GET'
      self.path = "/index.html"
      get_request(path)
    elsif choice == 'POST'
      self.path = ""
      post_request
    end
  end

  def viking_register
    puts 'registering you for raid'
    print "name? "
    name = gets.chomp
    print 'email? '
    email = gets.chomp
    self.emails[:viking] = {name:name, email:email}
    p emails
  end


  def get_request(path)
    # This is the HTTP request we send to fetch a file
    request = "GET #{path} HTTP/1.0\r\n\r\n"


    socket = TCPSocket.open(host,port)  # Connect to server
    socket.print(request)               # Send request
    response = socket.read              # Read complete response
    # Split response at first blank line into headers and body
    #headers,body = response.split("\r\n\r\n", 2) 
    print response# And display it
  end

  def post_request
    # This is the HTTP request we send to fetch a file
    request = "POST #{path} HTTP/1.0\r\n"
    viking_register

    socket = TCPSocket.open(host,port)  # Connect to server
    socket.print(request)               # Send request
    response = socket.read              # Read complete response
    # Split response at first blank line into headers and body
    #headers,body = response.split("\r\n\r\n", 2) 
    print response# And display it

  end
end

a = Browser.new
a.request_choice
