require 'rails_helper'

RSpec.describe User do
  describe 'associations' do
    it { is_expected.to have_many(:friendships).dependent(:destroy) }
    it { is_expected.to have_many(:friends).through(:friendships).source(:friend) }
    it { is_expected.to have_many(:sleep_records).dependent(:destroy) }
  end
end
