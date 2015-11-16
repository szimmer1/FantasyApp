class AddMflPlayerIdToPlayers < ActiveRecord::Migration
  def change
  	add_column :players, :mfl_player_id, :integer
  end
end
