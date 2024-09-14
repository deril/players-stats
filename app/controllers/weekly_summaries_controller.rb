# frozen_string_literal: true

class WeeklySummariesController < ApplicationController
  skip_before_action :validate_request!, only: :show

  def show
    render json: WeeklySummariesShowAction.call(week: params[:week], year: params[:year], sort_by: params[:sort_by])
  rescue InvalidParamsError => e
    render json: { error: e.message }, status: :bad_request
  end
end
