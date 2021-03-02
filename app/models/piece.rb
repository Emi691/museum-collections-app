class Piece < ActiveRecord::Base
    belongs_to :user
    has_many :treatments
end
