require 'rails_helper'

RSpec.describe RecognitionsService do
  let(:voter) { 'U123456' }

  context '#create_recognition' do
    it 'creates a recognition for an downvote' do
      recognition = described_class.create_recognition('abc123', 'C123456', 'someone', '--', 'for doing something', voter, '123456.123456', true)
      expect(recognition.votes.first.point).to eq(-1)
    end

    it 'creates a recognition for a downvote with emoji' do
      recognition = described_class.create_recognition('abc123', 'C123456', 'someone', ':thumbsdown:', 'for doing something', voter, '123456.123456', true)
      expect(recognition.votes.first.point).to eq(-1)
    end

    it 'creates a recognition for an upvote' do
      recognition = described_class.create_recognition('abc123', 'C123456', 'someone', '++', 'for doing something', voter, '123456.123456', true)
      expect(recognition.votes.first.point).to eq(1)
    end

    it 'creates a recognition for a downvote' do
      recognition = described_class.create_recognition('abc123', 'C123456', 'someone', '--', 'for doing something', voter, '123456.123456', true)
      expect(recognition.votes.first.point).to eq(-1)
      expect(recognition.vote_direction).to be false
    end
  end

  context '#vote' do

    let(:recognition) do
      described_class.create_recognition('abc123', 'C123456', 'someone', '++', 'for doing something', voter, '123456.123456', true)
    end

    it 'adds an upvote' do
      described_class.vote('abc123', recognition, voter, '+1')
      expect(recognition.votes.length).to eq 2
    end

    it 'changes the direction of the vote' do
      described_class.vote('abc123', recognition, voter, '+1', false, true)
      expect(recognition.votes.last.point).to eq -1
    end
  end
end
