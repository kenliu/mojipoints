require 'rails_helper'

RSpec.describe SlackUserFormatter do
  describe '#format' do
    it 'formats' do
      expect(described_class.format('USLACKBOT1')).to eq '<@USLACKBOT1>'
    end
  end

  describe '#extract' do
    it 'extracts' do
      expect(described_class.extract('<@USLACKBOT1>')).to eq 'USLACKBOT1'
    end
  end
end