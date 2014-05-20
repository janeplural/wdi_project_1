class ReadrsController < ApplicationController

before_action :authenticate_with_basic_auth

	def unsave_piece
		Readr.find_by(
			user_id: current_user.id,
			piece_id: params[:piece_id]
			).destroy

		redirect_to "/users/#{current_user.id}"
	end

	# def mark_read
		
	# 	#redirect
	# end
	def update
		read_marker = Readr.find_by(
			user_id: current_user.id,
			piece_id: params[:piece_id],
			)

		read_marker.update(read: params[:read])
		# redirect_to "/users/#{current_user.id}/pieces/#{params[:piece_id]}"	

		redirect_to request.env["HTTP_REFERER"]
	end

end