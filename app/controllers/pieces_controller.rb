class PiecesController < ApplicationController

before_action :authenticate_with_basic_auth

	def index
	  # used this hardcoded variable to test my API all and ENV variable, SUCCESS!
	  # @hash=HTTParty.get("https://www.googleapis.com/books/v1/volumes?q=inauthor:edgar+allen+poe&filter=ebooks&#{GOOGLEBOOKS_CLIENT_ID}")
	end

	def results
		#this array will be .joined and .flattened to be placed inside the @hash API call

		all_searchterms = []
	  #create variable to pass for api call, account for when text fields are empty.
	  if params[:author] != nil
	  	author_searchterms = params[:author].split.join("+")
	  	author = "inauthor:#{author_searchterms}&"
	  	all_searchterms << author
	  end

	  if params[:title] != nil
	  	title_searchterms = params[:title].split.join("+")
	  	title = "intitle:#{author_searchterms}&"
	  	all_searchterms << title
	  end

	  if params[:all_ebooks] == 1
	  	all_ebooks = "filter=ebooks&"
	    all_searchterms << all_ebooks
	  end

	  if all_searchterms.length > 0
	  	all_for_api = all_searchterms.flatten.join('')
	  end

		@google_hash=HTTParty.get("https://www.googleapis.com/books/v1/volumes?q=#{all_for_api}#{GOOGLEBOOKS_CLIENT_ID}")
		# binding.pry
	end


	def create
		# render json: params[:title]
		existing_piece = Piece.find_by(
				# title: piece_attributes[:title],
				# subtitle: piece_attributes[:subtitle], 
				# thumbnail: piece_attributes[:thumbnail], 
				# cost: piece_attributes[:cost], 
				# pub_date: piece_attributes[:pub_date], 
				# preview: piece_attributes[:preview], 
				# description: piece_attributes[:description]
				title: params[:title],
				subtitle: params[:subtitle], 
				thumbnail: params[:thumbnail], 
				cost: params[:cost], 
				pub_date: params[:pub_date], 
				preview: params[:preview], 
				description: params[:description]
				)
 		if existing_piece
				Readr.create(
				piece_id: existing_piece.id, 
				user_id: current_user.id,
				read: "false"
				)
		else 
				new_piece = Piece.create(
					# piece_attributes
					title: params[:title],
					subtitle: params[:subtitle], 
					thumbnail: params[:thumbnail], 
					cost: params[:cost], 
					pub_date: params[:pub_date], 
					preview: params[:preview], 
					description: params[:description]
				)

				Readr.create(
					piece_id: new_piece.id, 
					user_id: current_user.id,
					read: "false"
					)
			end

		redirect_to "/users/#{current_user.id}"
	end

	def show
		@piece = Piece.find(params[:id])
		@readr =  Readr.find_by( 
			user_id: current_user.id, 
			piece_id: @piece.id 
			) 
	end


	# private

	# def piece_attributes
	# 	binding.pry
	# 	params.require(:piece).permit(				
	# 		:title, :subtitle, :thumbnail, :cost, :pub_date, :preview, :description)
		
	# end


end