# frozen_string_literal: true

class PlaythroughsController < ApplicationController
  def create
    playthrough = Playthrough.new(playthrough_params)
    if playthrough.save
      render json: playthrough, status: :created
    else
      render json: playthrough.errors, status: :unprocessable_entity
    end
  end

  private

  def playthrough_params
    @validated_params[:playthrough]
  end
end
