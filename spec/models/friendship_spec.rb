require 'rails_helper'

RSpec.describe Friendship do
  let(:user) { create(:user) }
  let(:friend) { create(:user) }

  describe 'validations' do
    it 'validates the uniqueness of friend_id within the scope of user_id' do
      described_class.create(user: user, friend: friend)
      expect(described_class.new(user: user, friend: friend)).not_to be_valid
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:friend).class_name('User') }
  end
end
