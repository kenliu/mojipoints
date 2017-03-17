require 'rails_helper'

RSpec.describe Commands::ScrubCommand do

  let(:public_channel) { 'C12345678' }
  let(:dm_channel) { 'D12345678' }
  let(:bot_user) { 'U12345678' }

  let(:bot_userid) { 'UBOT12345' }
  let(:teamid) { 'T123456' }
  let!(:slack_team) { SlackTeam.create(teamid: teamid, bot_userid: bot_userid, bot_oauth_access_token: '123', oauth_access_token: '123')}
  let(:initialize_params) { { team_id: teamid, user: bot_userid } }
  let(:original_ts) { '123456.12345' }
  let(:channel) { 'C123456' }
  let(:subject_user) { 'U123456' }
  let(:recognition_subject) { 'foo' }
  let(:voter) { 'U111111' }
  let!(:recognition) {
    RecognitionsService.create_recognition(
      teamid,
      channel,
      recognition_subject,
      '++',
      'test reason',
      voter,
      original_ts,
      true
    )
  }

  subject { described_class.new(teamid: teamid, bot_user: bot_user) }

  describe '#match' do
    it 'matches "scrub" in DM channel' do
      expect(subject.match(channel: dm_channel, message: 'scrub foo')).to be_truthy
    end

    it 'matches "@bot_user scrub" in public channel' do
      expect(subject.match(channel: public_channel, message: '<@U12345678> scrub foo')).to be_truthy
    end

    it 'doesn\'t match "scrub" in public channel' do
      expect(subject.match(channel: public_channel, message: 'scrub foo')).to be_falsey
    end
  end

  describe '#response' do
    it 'responds' do
      subject.response(params: nil, message: 'scrub ' + recognition_subject)
      expect(Recognition.count).to eq 0
    end
  end
end
