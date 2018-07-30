require 'rails_helper'

RSpec.describe Commands::TopCommand do

  let(:public_channel) { 'C12345678' }
  let(:dm_channel) { 'D12345678' }
  let(:bot_user) { 'U12345678' }

  subject { described_class.new(bot_user: bot_user) }

  describe '#match' do
    it 'matches "top" in DM channel' do
      expect(subject.match(channel: dm_channel, message: 'top')).to be_truthy
    end

    it 'matches "@bot_user top" in public channel' do
      expect(subject.match(channel: public_channel, message: '<@U12345678> top')).to be_truthy
    end

    it 'doesn\'t match "top" in public channel' do
      expect(subject.match(channel: public_channel, message: 'top')).to be_falsey
    end
  end

  describe '#response' do
    it 'responds' do
      # TODO here we have to populate the database with some test data so that we can
      # generate a response
      # or we inject a mock PointsService instead
      expect(subject.response(params: nil)[:text]).to start_with("")
    end
  end
end
