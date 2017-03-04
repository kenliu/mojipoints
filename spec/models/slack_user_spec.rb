require 'rails_helper'

RSpec.describe SlackUser, type: :model do

  context 'userid format validation' do
    let(:valid) { 'U42DESEA3' }
    invalid = %w(U u 42DESEA3 <@U42DESEA3>)

    it 'accepts valid userid' do
      subject.slack_userid = valid
      expect(subject.valid?).to be_truthy
    end

    invalid.each do |userid|
      it "rejects invalid userid #{userid}" do
        subject.slack_userid = userid
        expect(subject.valid?).to be_falsy
      end
    end
  end
end
