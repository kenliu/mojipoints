require 'rails_helper'

RSpec.describe ScoreMessageFormatter do
  describe '#format_slack_message' do
    let(:recognition) { RecognitionsService.create_recognition('123','c123', 'U123456', '++', 'test reason', 'U123456', '123456.12345', true) }
    let(:recognition_no_reason) { Recognition.new(subject: 'bobby') }

    it 'formats recognition message with no reason' do
      message = described_class.format_slack_message(recognition_no_reason)
      expect(message['text']).to be_nil
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
    end

    it 'formats recognition message with reason' do
      message = described_class.format_slack_message(recognition)
      expect(message['text']).to start_with('1 of which are for')
    end
  end
end