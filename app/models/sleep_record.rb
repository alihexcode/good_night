# frozen_string_literal: true

class SleepRecord < ApplicationRecord
  belongs_to :user

  scope :past_n_days, ->(user, days) { where(user: user, end_time: (Time.current - days.days)..Time.current) }
  scope :order_by_sleep_length, -> { select('*, (end_time - start_time) AS sleep_length').order('sleep_length DESC') }

  validates :start_time, :end_time, presence: true
  validates :start_time, :end_time, date_type: true
  validates_comparison_of :end_time, greater_than: :start_time
  validate :unique_sleep_record_date, on: :create

  def sleep_length_in_minutes
    ((end_time - start_time) / 60).to_i
  end

  private

  def unique_sleep_record_date
    return unless user.present? && user.sleep_records.exists?(['date(start_time) = ?', start_time&.to_date])

    errors.add(:base, :already_exists_for_this_date)
  end
end
