class TeamsController < ApplicationController
	def index
		@teams = Team.paginate(page: params[:page])
		expose @teams
	end
	def show
		@team = Team.find(params[:id])
		expose @team
	end
end
