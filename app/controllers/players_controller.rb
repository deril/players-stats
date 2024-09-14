# frozen_string_literal: true

class PlayersController < ApplicationController
  def create
    player = Player.new(player_params)
    if player.save
      render json: PlayerPresenter.new(player:), status: :created
    else
      render json: player.errors, status: :unprocessable_entity
    end
  end

  private

  def player_params
    params.require(:player).permit(:name)
  end
end
