require 'yaml'

string_from = lambda do |team|
	"Team.create!(name: %q(#{team['name']}), abrv: '#{team['team']}')\n"
end

namespace :db do
	namespace :gen_seed do
		task :teams => :environment do
			# open seed file for write
			abs_path = File.join(Rails.root, 'db', 'seeds', 'teams_seed.rb')
			File.open(abs_path, 'w') do |file|

				# get the set of teams, and make it unique 
				teams = Player.where(position: 'TMWR')
				teams.uniq! { |team| team.name }

				# write each team to file
				teams.each do |team|
						s = string_from.call team
						puts "Writing #{s}"
						file.puts s
				end 

			end
		end
	end
end