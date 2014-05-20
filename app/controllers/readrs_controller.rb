class ReadrsController < ApplicationController

before_action :authenticate_with_basic_auth

	def unsave_piece
		Readr.find_by(
			user_id: current_user.id,
			piece_id: params[:piece_id]
			).destroy

		redirect_to "/users/#{current_user.id}"
	end




end