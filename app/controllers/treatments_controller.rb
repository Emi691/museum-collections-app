class TreatmentsController < ApplicationController

    get '/treatments/:id/mark-as-done' do
        @treatment = Treatment.find_by(params)
        @piece = @treatment.piece
        if logged_in? && @piece.user == current_user
            if @piece.condition == @treatment.start_condition
                flash[:message] = "Please update condition to mark treatments as done."
                redirect to :"/pieces/#{@piece.id}"
            else
                @treatment.update(done: "true", end_condition: "#{@piece.condition}")
                @treatment.save
                flash[:message] = "treatment marked as done"
                redirect to :"/pieces/#{@piece.id}"
            end
        else
            redirect to :"/pieces/#{@piece.id}"
        end
    end

    get '/treatments/:id/remove' do
        @treatment = Treatment.find_by(params)
        @piece = @treatment.piece
        if logged_in? && @piece.user == current_user
            @treatment.delete
            redirect to :"/pieces/#{@piece.id}"
        else
            redirect to :"/pieces/#{@piece.id}"
        end
    end

end