class PiecesController < ApplicationController
    
    get '/pieces' do
        if logged_in?
            @pieces = Piece.all
            erb :"/pieces/index"
        else
            redirect to :"/users/login"
        end
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

    patch '/pieces/:id' do
        @piece = Piece.find_by(id: params[:id])
        @piece.update(params[:piece])
        params[:treatments].each do |treatement|
            treatment = Treatment.create(description: "#{treatment}", start_condition: params[:piece][:condition])
            treatment.piece = piece
        end
        @piece.save
    end

    get '/pieces/:id' do
        @piece = Piece.find_by(id: params[:id])
        erb :"/pieces/show"
    end

    get '/objects/:id/delete' do
        @piece = Piece.find_by(id: params[:id])
        @piece.treatments.each do |treatment|
            treatment.delete
        end
        @piece.delete
        redirect to "/pieces"
    end

end