class PiecesController < ApplicationController

before_action :authenticate_with_basic_auth

	def index
	  # working call from PRY
	  # hash=JSON.parse(HTTParty.get("https://www.googleapis.com/books/v1/volumes?q=inauthor:edgar+allen+poe&filter=ebooks&AIzaSyDIsaNKi0OnG6D3koSpwkkj2rMDkCD53-M").body)

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

		@hash=HTTParty.get("https://www.googleapis.com/books/v1/volumes?q=#{all_for_api}#{GOOGLEBOOKS_CLIENT_ID}")

	end

end