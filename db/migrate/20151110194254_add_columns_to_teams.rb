class AddColumnsToTeams < ActiveRecord::Migration
  def change
  	add_column :teams, :name, :string
  	add_column :teams, :abrv, :string
  end
end
