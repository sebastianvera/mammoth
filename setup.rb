require_relative 'rdio_consumer_credentials'
require_relative 'rdio'

if RDIO_TOKENS.empty? or ARGV[0].to_s == "--renew-tokens"
   # create an instance of the Rdio object with our consumer credentials
   rdio = Rdio.new([RDIO_CONSUMER_KEY, RDIO_CONSUMER_SECRET])

   # authenticate against the Rdio service
   url = rdio.begin_authentication('oob')

   puts 'Go to: ' + url
   kommand = "open #{url}"
   # Open url in the browser
   `#{kommand}`
   print 'Then enter the code: '
   verifier = gets.strip
   rdio.complete_authentication(verifier)

   # Get credentials file for updating tokens
   file = File.read("rdio_consumer_credentials.rb")
   replace = "RDIO_TOKENS=['#{rdio.token[0]}','#{rdio.token[1]}']"
   file = replace.gsub(/RDIO_TOKENS=\[\]/, replace)

   # Save tokens to file
   puts "Saving tokens to file #{Dir.pwd}/rdio_consumer_credentials.rb"
   File.open("rdio_consumer_credentials.rb","w") { |new_file| new_file.puts file}
else
   puts "You already got Rdio needed tokens, if you want to renew them use:\n \t ruby #$0 --renew-tokens"
end

