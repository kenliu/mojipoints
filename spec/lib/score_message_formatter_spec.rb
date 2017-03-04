require 'rails_helper'

RSpec.describe ScoreMessageFormatter do
  describe '#format_slack_message' do
    let(:recognition) { RecognitionsService.create_recognition('123','c123', 'U123456', '++', 'test reason', 'U123456', '123456.12345', true) }
    let(:recognition_not_user) { RecognitionsService.create_recognition('123','c123', 'foobar', '++', nil, 'U123456', '123456.12345', true) }
    let(:recognition_no_reason) { RecognitionsService.create_recognition('123','c123', 'U123456', '++', nil, 'U123456', '123456.12345', true) }

    context 'formatting recognition message' do
      it 'with thing as subject and no reason' do
        message = described_class.format_slack_message(recognition_not_user)
        expect(message[:text]).to be_nil
        expect(message[:title]).to eq 'foobar has 1 points'
      end

      it 'with user as subject and no reason' do
        message = described_class.format_slack_message(recognition_no_reason)
        expect(message[:text]).to be_nil
        expect(message[:title]).to eq '<@U123456> has 1 points'
      end

      it 'formats recognition message with reason' do
        message = described_class.format_slack_message(recognition)
        expect(message[:text]).to start_with('1 of which are for')
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