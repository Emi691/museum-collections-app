class PiecesController < ApplicationController
    
    get '/pieces' do
        if logged_in?
            @pieces = Piece.all
            erb :"/pieces/index"
        else
            redirect to :"/login"
        end
    end

    get '/pieces/new' do
        if logged_in?
            erb :"pieces/new"
        else
            redirect to :"/login"
        end
    end

    post '/pieces' do
        if !Piece.find_by(title: params[:piece][:title]) 
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
            flash[:message] = "New piece created!"
            redirect to :"/users/#{current_user.id}"
        else
            flash[:message] = "A piece with this title already exists, please try again."
            redirect to :'/pices/new'
        end
    end

    get '/pieces/:id/edit' do
        @piece = Piece.find_by(id: params[:id])
        @current_treatments = @piece.treatments.find_all{|treatment| treatment.done == nil}
        @past_treatments = @piece.treatments.find_all{|treatment| treatment.done == true}

        if logged_in? && @piece.user == current_user
             erb :"/pieces/edit"
        else
            redirect to :"/login"
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
            flash[:message] = "You have successfully edited #{@piece.title}"
            redirect to :"/pieces/#{@piece.id}"
        else
            flash[:message] = "You are unable to edit this piece."
            redierct to :"/users/#{current_user.id}"
        end
    end

    get '/pieces/:id/condition' do
        @piece = Piece.find_by(id: params[:id])
        if logged_in? && @piece.user == current_user
            erb :"/pieces/condition"
        else
           redirect to :"/users/#{current_user.id}"
        end
    end

    patch '/pieces/:id/condition' do
        @piece = Piece.find_by(id: params[:id])
        if logged_in? && @piece.user == current_user
            @piece.update(condition: params[:condition])
            @piece.save
            flash[:message] = "You have successfully update #{@piece.title}'s condition!"
            redirect to :"/pieces/#{@piece.id}"
        else
            flash[:message] = "You cannot update the condition of this piece." 
            redierct to :"/users/#{current_user.id}"
        end
    end

    get '/pieces/:id' do
        if logged_in?
        @piece = Piece.find_by(id: params[:id])
        erb :"/pieces/show"
        else
            redirect to :"/login"
        end
    end

    get '/pieces/:id/delete' do
        @piece = Piece.find_by(id: params[:id])
        if logged_in? && @piece.user == current_user
            @piece.treatments.each do |treatment|
                treatment.delete
            end
            @piece.delete
            flash[:message] = "#{@piece.title} has been deleted."
            redirect to :"/pieces"
        else
            flash[:message] = "You cannpt delete this piece."
            redirect to :"/pieces/#{@piece.id}"
        end
    end

end