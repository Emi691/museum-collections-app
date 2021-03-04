class PiecesController < ApplicationController
    
    get '/pieces' do
        @pieces = Piece.all
        erb :"/pieces/index"
    end

    get '/pieces/new' do
        erb :"pieces/new"
    end

    post '/pieces' do
        binding.pry
    end
    
    get '/pieces/:id' do
        @piece = Piece.find_by(id: params[:id])
        erb :"/pieces/show"
    end

end