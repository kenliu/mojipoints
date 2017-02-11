require 'rails_helper'

RSpec.describe DirectMessageResolver do
  let(:bot_user) { 'U42DFDT5H' }

  # private channel DM or MPIM DM
  # text: <@U42DFDT5H> help
  # channel: G45LMJFUM
  it 'processes a multi party direct message' do
    expect(described_class.filter('<@U42DFDT5H> help', bot_user, 'G45LMJFUM')).to eq 'help'
  end

  # DM channel message
  # text: <@U42DFDT5H> help
  # text: help
  # channel: D42DFDTC3
  context 'direct messages' do
    it 'processes a direct message' do
      expect(described_class.filter('help', bot_user, 'D42DFDTC3')).to eq 'help'
    end

    it 'processes a direct message with @upvotebot' do
      expect(described_class.filter('<@U42DFDT5H> help', bot_user, 'D42DFDTC3')).to eq 'help'
    end
  end

  # public channel DM
  # text: <@U42DFDT5H> help
  # channel: C43618DPY
  context 'public channel' do
    it 'processes a public channel message' do
      expect(described_class.filter('<@U42DFDT5H> help', bot_user, 'C43618DPY')).to eq 'help'
    end

    it 'ignores non bot messages' do
      expect(described_class.filter('help', bot_user, 'C43618DPY')).to be_nil
    end

    it 'ignores DM to other user' do
      expect(described_class.filter('<@U12345678> help', bot_user, 'C43618DPY')).to be_nil
    end
  end

  it 'processes a private channel message' do
    expect(described_class.filter('<@U42DFDT5H> help', bot_user, 'D42DFDTC3')).to eq 'help'
  end
end