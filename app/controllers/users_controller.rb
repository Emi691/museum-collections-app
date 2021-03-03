class UsersController < ApplicationController

    get '/signup' do
        erb :"/users/signup"
    end

    post '/signup' do
        @user = User.new(params)
        if @user.save && !@params.find_all{|element| element == ""}
            session[user_id] = @user.id 
            redirect to :"/users/#{@user.id}"
        else
            redirect to :"/signup"
        end
    end

    get '/login' do
        erb :"/users/login" 
    end

    post '/login' do
        @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
            params[:user_id] = @user.id
            redirect to :"/users/#{@user.id}"
        else
            redirect to :"/users/login"
        end
    end

    get '/users/:id' do
        @user = User.find_by(id: params[:id]) 
        erb :"/users/show"
    end

    get '/logout' do
        session.clear
        redirect to "/"
    end

end