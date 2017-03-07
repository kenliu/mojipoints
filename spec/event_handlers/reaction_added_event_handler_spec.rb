require 'rails_helper'

RSpec.describe ReactionAddedEventHandler do
  let(:teamid) { 'T123456' }
  let(:bot_userid) { 'UBOT12345' }
  let!(:slack_team) { SlackTeam.create(teamid: teamid, bot_userid: bot_userid, bot_oauth_access_token: '123', oauth_access_token: '123')}
  let(:initialize_params) { { team_id: teamid, user: bot_userid } }
  let(:slack_api) { double('slack_api') }
  let(:original_ts) { '123456.12345' }
  let(:channel) { 'C123456' }
  let(:subject_user) { '<@U123456>' }
  let(:voter) { 'U111111' }
  let!(:recognition) { RecognitionsService.create_recognition(teamid, channel, subject_user, '++', 'test reason', voter, original_ts, true) }
  let(:bot_msg_ts) { '123456.123456' }
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

  subject { described_class.new(initialize_params, slack_api) }

  it 'ignores self-votes' do
    params[:event][:item][:ts] = original_ts
    params[:event][:user] = 'U123456'
    recognition.bot_msg_ts = bot_msg_ts
    recognition.save!

    expected = {
        attachments: [
            {
                fallback: "foo has 1 points",
                title: "foo has 1 points",
                footer: ":thumbsup: by <@user>"
            }
        ],
        channel: 'channel'
    }
    expect(Recognition.count).to eq 1
    expect(recognition.votes.size).to eq 1 # precondition

    expect(slack_api).not_to receive(:chat_update)

    subject.handle(params)

    recognition = Recognition.first
    expect(recognition.votes.size).to eq 1
  end

  it 'posts reaction on the recognition message' do
    params[:event][:item][:ts] = original_ts

    recognition.bot_msg_ts = bot_msg_ts
    recognition.save!

    expected = {
      attachments: [
        {
          fallback: "foo has 1 points",
          title: "foo has 1 points",
          footer: ":thumbsup: by <@user>"
        }
      ],
      channel: 'channel'
    }
    expect(Recognition.count).to eq 1
    expect(recognition.votes.size).to eq 1 # precondition

    expect(slack_api).to receive(:chat_update)

    subject.handle(params)

    recognition = Recognition.first
    expect(recognition.votes.size).to eq 2
    expect(recognition.votes.last.first_vote).to be_falsey
  end

  it 'upvotes a thing with no reason' do
    recognition.bot_msg_ts = bot_msg_ts
    recognition.save!

    expected = {
      attachments: [
        {
            fallback: "foo has 1 points",
            title: "foo has 1 points",
            footer: ":thumbsup: by <@user>"
        }
    ],
      channel: 'channel'
    }
    expect(Recognition.count).to eq 1
    expect(recognition.votes.size).to eq 1 # precondition

    expect(slack_api).to receive(:chat_update)

    subject.handle(params)

    recognition = Recognition.first
    expect(recognition.votes.size).to eq 2
    expect(recognition.votes.last.first_vote).to be_falsey
  end
end
