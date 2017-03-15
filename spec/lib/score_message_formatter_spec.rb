require 'rails_helper'

RSpec.describe ScoreMessageFormatter do
  describe '#format_slack_message' do
    let(:teamid) { 'T123' }
    let(:voterid) { 'U123456' }
    let(:recognition) { RecognitionsService.create_recognition(teamid, 'c123', 'U123456', '++', 'test reason', voterid, '123456.12345', true) }
    let(:recognition_not_user) { RecognitionsService.create_recognition(teamid, 'c123', 'foobar', '++', nil, voterid, '123456.12345', true) }
    let(:recognition_no_reason) { RecognitionsService.create_recognition(teamid, 'c123', '<@U123456>', '++', nil, voterid, '123456.12345', true) }

    context 'formatting recognition message' do
      it 'with thing as subject and no reason' do
        message = described_class.format_slack_message(recognition_not_user)
        expect(message[:text]).to be_nil
        expect(message[:title]).to eq 'foobar has 1 point'
      end

      it 'with user as subject and no reason' do
        message = described_class.format_slack_message(recognition_no_reason)
        expect(message[:text]).to be_nil
        expect(message[:title]).to eq '<@U123456> has 1 point'
      end

      it 'formats recognition message with reason' do
        message = described_class.format_slack_message(recognition)
        expect(message[:text]).to start_with('1 of which are for')
      end
    end

    context 'formatting recognition message with pluralization' do
      let(:emoji) { 'thumbsup' }

      it 'with thing as subject and no reason' do
        RecognitionsService.vote(teamid, recognition_not_user, voterid, emoji)
        message = described_class.format_slack_message(recognition_not_user)
        expect(message[:text]).to be_nil
        expect(message[:title]).to eq 'foobar has 2 points'
      end

      it 'with user as subject and no reason' do
        RecognitionsService.vote(teamid, recognition_no_reason, voterid, emoji)
        message = described_class.format_slack_message(recognition_no_reason)
        expect(message[:text]).to be_nil
        expect(message[:title]).to eq '<@U123456> has 2 points'
      end
    end

    context 'formatting "by" field' do
      it 'shows thumbsup emoji' do
        message = described_class.format_slack_message(recognition)
        expect(message[:footer]).to eq(':thumbsup: by <@U123456>')
      end

      it 'shows thumbsdown emoji' do
        recognition.vote_direction = false
        message = described_class.format_slack_message(recognition)
        expect(message[:footer]).to eq(':thumbsdown: by <@U123456>')
      end

      it 'shows multiple users'
    end
  end
end