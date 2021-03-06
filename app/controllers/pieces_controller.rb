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
        if logged_in?
            erb :"pieces/new"
        else
            redirect to :"/users/login"
        end
    end

    post '/pieces' do
        @piece = Piece.create(params[:piece])
        @piece.user = current_user
        params[:treatments].each do |treatment|
            if treatment.length > 0 
            treatment = Treatment.create(description: "#{treatment}", start_condition: params[:piece][:condition])
            treatment.piece = @piece
            treatment.save
            end
        end
        @piece.save
        redirect to :"/users/#{current_user.id}"
    end

    get '/pieces/:id/edit' do
        @piece = Piece.find_by(id: params[:id])
        @current_treatments = @piece.treatments.map{|treatment| treatment.done == nil}
        @past_treatments = @piece.treatments.map{|treatment| treatment.done == true}
        if logged_in? && @piece.user == current_user
             erb :"/pieces/edit"
        else
            redirect to :"/users/#{current_user.id}"
        end
    end

    patch '/pieces/:id' do
        @piece = Piece.find_by(id: params[:id])
        if logged_in? && @piece.user == current_user
            @piece.update(params[:piece])
            params[:treatment].each do |treatment|
                new_treatment = Treatment.create(description: treatment, start_condition: params[:piece][:condition])
                new_treatment.piece = @piece
                new_treatment.save
            end
            @piece.save
            redirect to :"/pieces/#{@piece.id}"
        else
            redierct to :"/users/#{current_user.id}"
        end
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
        redirect to :"/pieces"
    end

end