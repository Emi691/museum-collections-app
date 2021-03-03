class PiecesController < ApplicationController
    
    get '/pieces' do
        erb :"/pieces/index"
    end
end