class Piece < ActiveRecord::Base
	has_many :readrs
	has_many :users, through: :readrs
end