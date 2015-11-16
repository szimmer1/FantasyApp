class PlayerController < ApiController
	def index
		@players = Player.paginate(page: params[:page])
		expose @players
	def show
		@player = Player.find_by(params[:id])
		expose @player
	end
end
