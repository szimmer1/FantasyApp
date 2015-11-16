require 'typhoeus'
require 'json'
require 'yaml'
require_relative 'utils'

# returns string to create Player record from player hash
get_player_str = lambda do |player|
	"Player.create!(name: %q(#{player['name']}), position: '#{player['position']}', team: '#{player['team']}', mfl_player_id: #{player['id'].tr('0', '')}) unless Player.find_by(name: %q(#{player['name']}))\n"
end

# handles response from MFL API - parses and writes to seed file
handle_response = Proc.new do |res|
		if res.success?
			puts "request success"
			decoded = JSON.parse(res.response_body)
		
			File.open(File.expand_path('../db/seeds/players_seed.rb'), 'w') do |f|
				decoded['players']['player'].each do |player|
					s = get_player_str.call(player)

					puts "writing #{s}"
					f.puts(s)
				end
			end	

			#seed_string = decoded['players']['player'].reduce('') do |memo, player|
				# add player if name not already in the db
			#	memo += get_player_str.call player
			#end

			#puts seed_string, 'Generating seed file...'
			#SeedUtil::write_to_seed '../db/players_seed.rb', seed_string
			#puts "Done"
		elsif response.timed_out?
			puts "request timed out"
		else
			puts "request failed",res.code.to_s
		end
	end
			
# create request
req = Typhoeus::Request.new(SeedUtil::ABS_URL,
		method: :get,
		params: {
			TYPE: 'players',
			JSON: 1
		}
)

# assign event handler
req.on_complete &handle_response

# run request
req.run