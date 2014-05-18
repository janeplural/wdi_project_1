class PiecesController < ApplicationController

before_action :authenticate_with_basic_auth

def index
  # @pieces = Piece.all	
end

end