class PiecesController < ApplicationController

before_action :authenticate_with_basic_auth

def index
  # @hash=JSON.parse(HTTParty.get("https://www.googleapis.com/books/v1/volumes?q=inauthor:edgar+allen+poe&filter=ebooks&AIzaSyDIsaNKi0OnG6D3koSpwkkj2rMDkCD53-M").body)
  @hash=HTTParty.get("https://www.googleapis.com/books/v1/volumes?q=inauthor:edgar+allen+poe&filter=ebooks&#{GOOGLEBOOKS_CLIENT_ID}")
end

end