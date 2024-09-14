# frozen_string_literal: true

class WeeklySummariesShowAction < ApplicationAction
  def initialize(week:, year:, sort_by: nil, summary_generator: WeeklySummaryGenerator.new)
    @week = week.to_i
    @year = year.to_i
    @sort_by = sort_by
    @summary_generator = summary_generator
  end

  def call
    validate_input!

    {
      weekly_summary: summary.map { WeeklySummaryPresenter.new(player: _1) }
    }
  end

  private

  attr_reader :week, :year, :sort_by, :summary_generator

  def cache_key
    "weekly_summaries/#{year}/#{week}/#{sort_by || 'default'}"
  end

  def summary
    Rails.cache.fetch(cache_key, expires_in: Rails.application.config.weekly_summary_cache_ttl) do
      summary_generator.generate(week: week, year: year, sort_by: sort_by)
    end
  end

  def validate_input!
    schema = WeeklySummariesShowSchema
    result = schema.call(week: week, year: year, sort_by: sort_by)

    unless result.success?
      raise InvalidParamsError, result.errors
    end
  end
end
