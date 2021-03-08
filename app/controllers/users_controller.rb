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
            flash[:message] = "Login successful."
            redirect to :"/users/#{@user.id}"
        else
            flash[:message] = "Incorrect username or password, please try again."
            redirect to :"/login"
        end
    end

    get '/users/:id' do
        if logged_in?
        @user = User.find_by(id: params[:id]) 
        erb :"/users/show"
        else
            redirect to :"/login"
        end
    end

    get '/logout' do
        if logged_in?
            session.clear
            flash[:message] = "You are now logged out."
            redirect to "/login"
        else
            flash[:message] = "You must be logged in before loggin out."
            redirect to "/login"
        end
    end

end