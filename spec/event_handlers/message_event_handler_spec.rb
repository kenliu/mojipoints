require 'rails_helper'

RSpec.describe MessageEventHandler do
  let(:teamid) { 'T123456' }
  let(:bot_userid) { 'UBOT12345' }
  let!(:slack_team) { SlackTeam.create(teamid: teamid, bot_userid: bot_userid, bot_oauth_access_token: '123', oauth_access_token: '123')}
  let(:initialize_params) { { team_id: teamid, user: bot_userid } }
  let(:slack_api) { double('slack_api') }
  let(:bot_msg_ts) { '123456.123456' }
  let(:channel) { 'C123456' }

  subject { described_class.new(initialize_params, slack_api) }

  let(:params) do
    {
        event: {
            item: {
                ts: bot_msg_ts,
                channel: channel
            },
            channel: 'channel',
            user: 'UTESTUSER',
            reaction: '+1'
        }
    }
  end

  it 'doesn\'t handle messages with subtypes' do
    params[:event][:subtype] = 'message_deleted'
    expect(subject.handle(params)).to be_nil
  end

end
