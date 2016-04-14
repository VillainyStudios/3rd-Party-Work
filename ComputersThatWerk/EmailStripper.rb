################################################
#    Ruby Email Stripper
#    Created by: Joseph Preston
#    Created on: 04.12.2016
################################################

#  Required CSV for exporting
require 'csv'

#  Allows user to enter file location
puts 'Enter your file location.'

#  Strips leading and trailing whitespace and removes new line from file location
filename = gets.strip.chomp()

#  Reads the contents of the file into memory
@from = File.read(filename)

#  Scans the contents for REGEX defined email address, adds them to an array and removes any possible duplicates
emails = Array(@from.scan(/\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b/i)).uniq

#  Allows the user to input a filename to export to
puts 'Enter the name you wish the file to be.'

#  Strips leading and trailing whitespace and removes new line from export filename
output = gets.strip.chomp() + '.csv'

#  Creates file with given export filename under the current working directory
CSV.open(output, 'w') do |f| 
	emails.each do |x|
		f << [x]
	end
end
