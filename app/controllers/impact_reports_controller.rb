# frozen_string_literal: true

class ImpactReportsController < ApplicationController
  skip_before_action :validate_request!, only: :show

  def show
    render json: ImpactReportsShowAction.call
  end
end
