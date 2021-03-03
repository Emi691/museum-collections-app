class UsersController < ApplicationController

    get '/signup' do
        erb :"users/signup"
    end

    post '/signup' do
        @user = User.new(params)
        if @user.save && !@params.find_all{|element| element == ""}
            session[user_id] = @user.id 
            #redirect to :"/users/#{@user.id}"
        else
            redirect to :"/signup"
        end
    end
end