# frozen_string_literal: true

class ImpactReportsShowAction < ApplicationAction
  def initialize(impact_report_generator: ImpactReportGenerator.new)
    @impact_report_generator = impact_report_generator
  end
  def call
    {
      impact_report: impact_report.map do |player|
        ImpactReportPresenter.new(player: player)
      end
    }
  end

  private

  attr_reader :impact_report_generator

  def cache_key
    "impact_reports/#{[ Player.maximum(:updated_at), Playthrough.maximum(:updated_at) ].max.to_i}"
  end

  def impact_report
    Rails.cache.fetch(cache_key, expires_in: Rails.application.config.impact_report_cache_ttl) do
      impact_report_generator.generate
    end
  end
end
