class TreatmentsController < ApplicationController

    get '/treatments/:id/mark-as-done' do
        @treatment = Treatment.find_by(id: params[:id])
        @piece = @treatment.piece
        if logged_in? && @piece.user == current_user
            if @piece.condition == @treatment.start_condition
                redirect to :"/piece/#{@piece.id}"
            else
                @treatment.update(done: "true", end_condition: "#{@piece.condition}")
                @treatment.save
                redirect to :"/piece/#{@piece.id}"
            end
        else
            redirect to :"/piece/#{@piece.id}"
        end
    end

    get '/treatments/:id/remove' do
        @treatment = Treatment.find_by(id: params[:id])
        @piece = @treatment.piece
        if logged_in? && @piece.user == current_user
            @treatment.delete
        else
            redirect to :"/piece/#{@piece.id}"
        end
    end

end