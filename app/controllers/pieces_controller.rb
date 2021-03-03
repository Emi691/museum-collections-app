class PiecesController < ApplicationController
    
    get '/pieces' do
        @pieces = Piece.all
        erb :"/pieces/index"
    end
end