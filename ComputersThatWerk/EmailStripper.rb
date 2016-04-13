#Ruby Email Stripper

output = 'emails.csv'

puts 'Enter your file location.'

file = gets.strip.chomp()

puts file
puts File.exists?('"' + file + '"')

@from = File.read('"' + file + '"')

emails = Array(@from.scan(/\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b/i)).uniq

open(output, 'w') { |f| f.puts emails * "," }
