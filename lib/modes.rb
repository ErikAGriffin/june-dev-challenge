def slowapi(number)
  file = File.new('slowapi.txt','w')
  number.times {file.puts(HTTPHandler.get_url('http://slowapi.com/delay/0.3'));print"."}
  puts ""
end

def minimum_path_sum(file)
  raise "Missing argument -f FILE for 'minimum_path_sum'" if !file
  puts TreeParser.parse_least_sum(file)
end
