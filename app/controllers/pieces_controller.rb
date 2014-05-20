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
		# binding.pry
		# render json: params[:title]
		Piece.create(
			title: params[:title],
			subtitle: params[:subtitle], 
			thumbnail: params[:thumbnail], 
			cost: params[:cost], 
			pub_date: params[:pub_date], 
			preview: params[:preview], 
			description: params[:description]
		)
		redirect_to "/users/#{current_user.id}"
	end

	# 	save_list.each do |piece|
	# 		new_piece = Piece.new
	# 		if piece.has_key?("title")
	# 			new_piece.title = piece.title
	# 		end
	# 		if piece.has_key?("subtitle")
	# 			new_piece.subtitle = piece.subtitle
	# 		end
	# 		if piece.has_key?("type")
	# 			new_piece.type = piece.type
	# 		end
	# 		if piece.has_key?("thumbnail")
	# 			new_piece.thumbnail = piece.thumbnail
	# 		end
	# 		if piece.has_key?("pub_date")
	# 			new_piece.pub_date = piece.pub_date
	# 		end
	# 		if piece.has_key?("preview")
	# 			new_piece.preview = piece.preview
	# 		end
	# 		if piece.has_key?("description")
	# 			new_piece.description = piece.description
	# 		end

	# 		Piece.save
	# 	end
	# end

end