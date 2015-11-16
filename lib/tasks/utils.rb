require 'typhoeus'
require 'json'
require 'yaml'

module SeedUtil

	BASE_DOMAIN = 'football.myfantasyleague.com/'
	API_BASEURL = '2013/export'
	ABS_URL = BASE_DOMAIN + API_BASEURL

	# opens a file and writes a string
	def SeedUtil.write_to_seed (filepath, string)
			File.open(filepath, 'w') do |f|
				puts "writing #{string} to #{filepath}"
				f.syswrite(string)
			end
	end


end