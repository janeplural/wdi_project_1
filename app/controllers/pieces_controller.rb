class PiecesController < ApplicationController

before_action :authenticate_with_basic_auth

	def index
	  # used this hardcoded variable to test my API all and ENV variable, SUCCESS!
	  # @hash=HTTParty.get("https://www.googleapis.com/books/v1/volumes?q=inauthor:edgar+allen+poe&filter=ebooks&#{GOOGLEBOOKS_CLIENT_ID}")
	end

	def show 
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
		new_piece = Piece.create(
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

		redirect_to "/users/#{current_user.id}"
	end

end