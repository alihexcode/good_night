# frozen_string_literal: true

class SleepRecord < ApplicationRecord
  belongs_to :user

  scope :past_n_days, ->(user, days) { where(user: user, end_time: (Time.current - days.days)..Time.current) }
  scope :order_by_sleep_length, -> { select('*, (end_time - start_time) AS sleep_length').order('sleep_length DESC') }

  validate :unique_sleep_record_date, on: :create

  private

  def unique_sleep_record_date
    return unless user.sleep_records.exists?(['date(start_time) = ? OR date(end_time) = ?', start_time.to_date, end_time.to_date])

    errors.add(:base, :already_exists_for_this_date)
  end
end
