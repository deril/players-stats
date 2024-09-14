# frozen_string_literal: true

require "rails_helper"

RSpec.describe ImpactReportsShowAction do
  describe "#call" do
    let(:impact_report_generator) { instance_double(ImpactReportGenerator) }
    let(:impact_report) { [ ImpactPlayer.new(id: 1, name: "Player 1", impact: 50) ] }

    before do
      allow(impact_report_generator).to receive(:generate).and_return(impact_report)
    end

    it "returns the impact report" do
      result = described_class.call(impact_report_generator: impact_report_generator)

      expect(result[:impact_report]).to all(be_a(ImpactReportPresenter))
      expect(result[:impact_report].map(&:to_hash)).to eq([
        { player_id: 1, player_name: "Player 1", impact: 50 }
      ])
    end
  end
end
