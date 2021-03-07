class UsersController < ApplicationController

    get '/signup' do
        erb :"/users/signup"
    end

    post '/users/signup' do
        if !!User.find_by(username: params[:username])
            flash[:message] = "The username you chose is already taken, please choose a different username."
            redirect to :"/signup"
        else
            @user = User.new(params)
            if @user.save && !@params.find{|element| element == ""}
                session[:user_id] = @user.id 
                flash[:message] = "You have sucessfully signed up!"
                redirect to :"/users/#{@user.id}"
            else
                flash[:message] = "You must fill all fields to sign up."
                redirect to :"/signup"
            end
        end
    end

    get '/login' do
        erb :"/users/login" 
    end

    post '/login' do
        @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect to :"/users/#{@user.id}"
        else
            flash[:message] = "Incorrect username or password, please try again."
            redirect to :"/users/login"
        end
    end

    get '/users/:id' do
        if logged_in?
        @user = User.find_by(id: params[:id]) 
        erb :"/users/show"
        else
            redirect to :"/users/login"
        end
    end

    get '/logout' do
        session.clear
        redirect to "/login"
    end

end