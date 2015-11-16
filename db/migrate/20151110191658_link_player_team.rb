require 'yaml'

class LinkPlayerTeam < ActiveRecord::Migration
  def change
  	change_table :players do |t|
  		t.belongs_to :team
  	end

  	# index teams by abrv

  	teams = Hash.new
  	Team.all.each do |team|
  		puts team.abrv
  		teams[team.abrv.to_sym] = team.id
  	end

  	Player.all.each do |player|
  		player.update(team_id: teams[player[:team].to_sym])
  	end
  end
end
