class TreatmentsController < ApplicationController

    get '/treatments/:id/mark_as_done' do
        @treatment = Treatment.find_by(id: params[:id])
        @piece = @treatment.piece
        @treatment.update(done: "true", end_condition: "#{@piece.condition}")
    end
end