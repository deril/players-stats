# frozen_string_literal: true

class PlayerPresenter < ApplicationPresenter
  def to_hash
    {
      id: player.id,
      name: player.name
    }
  end
end
