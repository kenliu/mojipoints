require 'rails_helper'

RSpec.describe Commands::RecognitionCommand do

  let(:team_id) { 'team123' }
  subject { described_class.new(team_id: team_id) }
  let(:vote_strings) { %w(++ :thumbsup: :heavy_plus_sign: :thumbsdown: :heavy_minus_sign:) }

  describe '#match' do
    context 'valid upvotes and downvotes' do

      # TODO figure out how to make this loop create different examples
      it 'votes with with no reason' do
        vote_strings.each do |votestring|
          text = "<@U44BY21U4> #{votestring}"
          expect(subject.match(message: text)).to be_truthy
          expect(subject.vote_string).to eq(votestring)
          expect(subject.subject).to eq('<@U44BY21U4>')
        end
      end

      it 'votes with reason' do
        vote_strings.each do |votestring|
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
      specify '+-'
      specify '---'
      specify '+++'
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
            fallback: "foo has 1 points",
            title: "foo has 1 points",
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

      it 'rejects self-upvotes for non-user subjects' do
      end
    end
  end
end
