require 'rails_helper'

RSpec.describe SlackUserFormatter do
  describe '#format' do
    it 'formats' do
      expect(described_class.format('USLACKBOT1')).to eq '<@USLACKBOT1>'
    end
  end

  describe '#unescape' do
    it 'unescapes' do
      expect(described_class.unescape('<@USLACKBOT1>')).to eq 'USLACKBOT1'
    end

    it 'passes through non-escaped string' do
      expect(described_class.unescape('blah blah blah')).to eq 'blah blah blah'
    end
  end
end