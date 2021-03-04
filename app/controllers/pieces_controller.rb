class PiecesController < ApplicationController
    
    get '/pieces' do
        @pieces = Piece.all
        erb :"/pieces/index"
    end

    get '/pieces/new' do
        erb :"pieces/new"
    end

    post '/pieces' do
        piece = Piece.create(params[:piece])
        params[:treatments].each do |treatement|
            treatment = Treatment.create(description: "#{treatment}", start_condition: params[:piece][:condition])
            treatment.piece = piece
        end
        @piece.save
        #binding.pry
    end

    get '/pieces/:id/edit' do
        @piece = Piece.find_by(id: params[:id])
        erb :"/pieces/edit"
    end

    get '/pieces/:id' do
        @piece = Piece.find_by(id: params[:id])
        erb :"/pieces/show"
    end

end