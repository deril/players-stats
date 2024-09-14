# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'WeeklySummaryGenerator' do
  subject(:service) { WeeklySummaryGenerator.new }

  describe '#generate' do
    it 'returns a weekly summary' do
      date_in_report = Date.new(2020, 1, 1)
      date_not_in_report = Date.new(2020, 1, 8)
      player = create(:player)
      player2 = create(:player)
      create(:playthrough, player: player, timestamp: date_in_report, score: 100, time_spent: 60)
      create(:playthrough, player: player, timestamp: date_in_report + 1.day, score: 200, time_spent: 120)
      create(:playthrough, player: player2, timestamp: date_in_report, score: 400, time_spent: 240)
      create(:playthrough, player: player2, timestamp: date_not_in_report, score: 800, time_spent: 480)

      result = service.generate(week: 1, year: 2020)

      expect(result).to match([
         have_attributes(id: player.id, name: player.name, total_score: 300, total_time_spent: 180),
         have_attributes(id: player2.id, name: player2.name, total_score: 400, total_time_spent: 240)
      ])
    end

    it 'returns a weekly summary sorted by total_score' do
      date_in_report = Date.new(2020, 1, 1)
      player = create(:player)
      player2 = create(:player)
      create(:playthrough, player: player, timestamp: date_in_report, score: 100, time_spent: 60)
      create(:playthrough, player: player2, timestamp: date_in_report, score: 200, time_spent: 120)

      result = service.generate(week: 1, year: 2020, sort_by: :total_score)

      expect(result).to match([
         have_attributes(id: player.id, name: player.name, total_score: 100, total_time_spent: 60),
         have_attributes(id: player2.id, name: player2.name, total_score: 200, total_time_spent: 120)
      ])
    end

    it 'returns a weekly summary sorted by total_time_spent' do
      date_in_report = Date.new(2020, 1, 1)
      player = create(:player)
      player2 = create(:player)
      create(:playthrough, player: player, timestamp: date_in_report, score: 100, time_spent: 60)
      create(:playthrough, player: player2, timestamp: date_in_report, score: 200, time_spent: 120)

      result = service.generate(week: 1, year: 2020, sort_by: :total_time_spent)

      expect(result).to match([
         have_attributes(id: player.id, name: player.name, total_score: 100, total_time_spent: 60),
         have_attributes(id: player2.id, name: player2.name, total_score: 200, total_time_spent: 120)
      ])
    end
  end
end
