require 'rails_helper'

RSpec.describe Commands::WelcomeMessage do
  let(:public_channel) { 'C12345678' }
  let(:dm_channel) { 'D12345678' }
  let(:bot_user) { 'U12345678' }

  subject { described_class.new(bot_user: bot_user) }

  describe '#match' do
    it 'matches "help"' do
      expect(subject.match(message: 'help', channel: dm_channel)).to be_truthy
    end
  end

  describe '#response' do
    it 'responds' do
      params = nil
      expect(subject.response(params: params)[:text]).to start_with("happy to help!")
    end
  end
end
