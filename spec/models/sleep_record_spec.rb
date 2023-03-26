require 'rails_helper'

RSpec.describe SleepRecord do
  let(:user) { create(:user) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:start_time) }
    it { is_expected.to allow_value(Time.current).for(:start_time) }
    it { is_expected.not_to allow_value('not a date').for(:start_time) }
    it { is_expected.not_to allow_value('not a date').for(:end_time) }

    context 'when validates uniqueness of sleep_record date' do
      let(:existing_sleep_record) do
        create(:sleep_record, user: user, start_time: Time.current.beginning_of_day, end_time: Time.current.end_of_day)
      end
      let(:new_sleep_record) do
        build(:sleep_record, user: user, start_time: existing_sleep_record.start_time, end_time: existing_sleep_record.end_time)
      end

      it do
        new_sleep_record.valid?
        expect(new_sleep_record.errors.full_messages.to_sentence).to include('already exists for this date')
      end
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end

  describe 'scopes' do
    let!(:recent_sleep_record) { create(:sleep_record, user: user, start_time: 4.hours.ago, end_time: 1.hour.ago) }
    let!(:older_sleep_record) { create(:sleep_record, user: user, start_time: 2.days.ago, end_time: 1.day.ago) }

    describe '.past_n_days' do
      it { expect(described_class.past_n_days(user, 1)).to include(recent_sleep_record) }
      it { expect(described_class.past_n_days(user, 1)).not_to include(older_sleep_record) }
    end

    describe '.order_by_sleep_length' do
      it 'orders sleep records by sleep length in descending order' do
        expect(described_class.order_by_sleep_length.first.id).to eq(older_sleep_record.id)
      end
    end
  end

  describe '#sleep_length_in_minutes' do
    let(:sleep_record) { build(:sleep_record, start_time: 1.hour.ago, end_time: Time.current) }

    it 'calculates sleep length in minutes' do
      expect(sleep_record.sleep_length_in_minutes).to eq(60)
    end
  end
end
