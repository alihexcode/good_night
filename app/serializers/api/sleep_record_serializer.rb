module Api
  class SleepRecordSerializer < BaseSerializer
    enable_caching

    attributes :id, :start_time, :end_time, :sleep_length_in_minutes, :created_at, :updated_at

    belongs_to :user
  end
end
