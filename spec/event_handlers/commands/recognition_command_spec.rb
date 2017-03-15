require 'rails_helper'

RSpec.describe Commands::RecognitionCommand do

  let(:team_id) { 'team123' }
  let(:bot_user) { 'UBOTUSER' }
  subject { described_class.new(teamid: team_id, bot_user: bot_user) }

  describe '#match' do
    context 'valid upvotes and downvotes' do
      vote_strings = %w(++ :thumbsup: :heavy_plus_sign: :thumbsdown: :heavy_minus_sign:)

      vote_strings.each do |votestring|
        it "votes with with no reason using #{votestring}" do
          text = "<@U44BY21U4> #{votestring}"
          expect(subject.match(message: text)).to be_truthy
          expect(subject.vote_string).to eq(votestring)
          expect(subject.subject).to eq('<@U44BY21U4>')
        end
      end

      vote_strings.each do |votestring|
        it "votes with reason using #{votestring}" do
          text = "<@U44BY21U4> #{votestring} for something"
          expect(subject.match(message: text)).to be_truthy
          expect(subject.vote_string).to eq(votestring)
          expect(subject.subject).to eq('<@U44BY21U4>')
        end
      end

      it 'upvotes a thing with no reason' do
        text = 'foo++'
        expect(subject.match(message: text)).to be_truthy
        expect(subject.vote_string).to eq('++')
        expect(subject.subject).to eq('foo')
      end

      it 'downvotes with no reason'

      it 'downvotes with reason'

      it 'upvotes with reason and extra spaces'

      it 'matches self votes'
    end

    context 'invalid upvotes and downvotes' do
      specify 'when ++ is followed by text besides `for`' do
        text = 'foo++ blah blah other stuff'
        expect(subject.match(message: text)).to be_falsey
      end

      %w(-- ++ foo+- foo--- foo+++).each do |text|
        specify "when #{text}" do
          expect(subject.match(message: text)).to be_falsey
        end
      end
    end
  end

  describe '#response' do
    it 'upvotes a thing with no reason' do
      text = 'foo++'
      subject.match(message: text)
      params = {
        event: {
          channel: 'channel',
          user: 'U123456',
          ts: '123456.123456'
        }
      }
      expected = {
        attachments: [
          {
            fallback: "foo has 1 point",
            title: "foo has 1 point",
            footer: ":thumbsup: by <@U123456>"
          }
        ],
        channel: 'channel'
      }
      expect(Recognition.count).to eq 0 # precondition
      expect(subject.response(message: nil, params: params)).to eq(expected)

      # assert first voter
      recognition = Recognition.first
      expect(recognition).to be_truthy
      expect(recognition.votes.size).to eq 1
      expect(recognition.votes.first.first_vote).to be_truthy
    end

    it 'upvotes a user with no reason' do
      text = '<@UABCDEFG> ++'
      subject.match(message: text)
      params = {
          event: {
              channel: 'channel',
              user: 'UVOTER',
              ts: '123456.123456'
          }
      }
      expected = {
          attachments: [
              {
                  fallback: "<@UABCDEFG> has 1 point",
                  title: "<@UABCDEFG> has 1 point",
                  footer: ":thumbsup: by <@UVOTER>"
              }
          ],
          channel: 'channel'
      }
      expect(Recognition.count).to eq 0 # precondition
      expect(subject.response(message: nil, params: params)).to eq(expected)

      # assert first voter
      recognition = Recognition.first
      expect(recognition).to be_truthy
      expect(recognition.votes.size).to eq 1
      expect(recognition.votes.first.first_vote).to be_truthy
    end

    context 'self-upvotes' do
      it 'rejects self-upvotes' do
        text = '<@U123456> ++'
        subject.match(message: text)
        params = {
          event: {
            channel: 'channel',
            user: 'U123456',
            ts: '123456.123456'
          }
        }
        expect(subject.response(message: nil, params: params)).to be_nil
      end
    end
  end

  context '#after_response' do
    let(:api) { double('slack_api') }
    before do
      text = '<@UABCDEFG> ++'
      subject.match(message: text)
      params = {
          event: {
              channel: 'channel',
              user: 'UVOTER',
              ts: '123456.123456'
          }
      }
      expected = {
          attachments: [
              {
                  fallback: "<@UABCDEFG> has 1 point",
                  title: "<@UABCDEFG> has 1 point",
                  footer: ":thumbsup: by <@UVOTER>"
              }
          ],
          channel: 'channel'
      }
      expect(Recognition.count).to eq 0 # precondition
      expect(subject.response(message: nil, params: params)).to eq(expected)
    end

    it 'posts a heavy plus reaction for an upvote' do
      subject.api = api
      expect(api).to receive(:reactions_add).with(name: "heavy_plus_sign", channel: "channel", timestamp: "12345.12345")
      subject.after_response(nil, {ts: '12345.12345'})
    end
  end
end
