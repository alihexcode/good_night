# frozen_string_literal: true

module Api
  class SleepRecordsController < BaseController
    before_action :set_current_user

    # GET /api/users/:user_id/sleep_records
    def index
      @sleep_records = current_user.sleep_records.order(created_at: :desc)

      render json: @sleep_records
    end

    # POST /api/users/:user_id/sleep_records
    def create
      @sleep_record = current_user.sleep_records.create!(sleep_record_params)

      render json: @sleep_record
    end

    private

    def sleep_record_params
      params.require(:sleep_record).permit(:start_time, :end_time)
    end
  end
end
