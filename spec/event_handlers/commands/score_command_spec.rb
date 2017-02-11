require 'rails_helper'

RSpec.describe Commands::ScoreCommand do

  let(:public_channel) { 'C12345678' }
  let(:dm_channel) { 'D12345678' }
  let(:bot_user) { 'U12345678' }

  subject { described_class.new(bot_user: bot_user) }

  describe '#match' do
    it 'matches "score" in DM channel' do
      expect(subject.match(channel: dm_channel, message: 'score something')).to be_truthy
    end

    it 'matches "@bot_user score" in public channel' do
      expect(subject.match(channel: public_channel, message: '<@U12345678> score something')).to be_truthy
    end

    it 'doesn\'t match "score" in public channel' do
      expect(subject.match(channel: public_channel, message: 'score something')).to be_falsey
    end
  end

  describe '#response' do
    it 'shows correct subject in response' do
      subject.match(channel: dm_channel, message: 'score something')
      expect(subject.response(params: nil)[:text]).to start_with("something has")
    end

    it 'shows correct user in response' do
      subject.match(channel: dm_channel, message: 'score <@U449MEXJ6>')
      expect(subject.response(params: nil)[:text]).to start_with("<@U449MEXJ6> has")
    end

    it 'shows correct user in response when using DM' do
      subject.match(channel: dm_channel, message: "#{bot_user} score <@U449MEXJ6>")
      expect(subject.response(params: nil)[:text]).to start_with("<@U449MEXJ6> has")
    end
  end
end
