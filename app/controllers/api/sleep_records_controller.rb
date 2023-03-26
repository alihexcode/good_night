# frozen_string_literal: true

module Api
  class SleepRecordsController < BaseController
    before_action :set_current_user
    after_action :paginate, only: :index

    # GET /api/users/:user_id/sleep_records
    def index
      @sleep_records = current_user.sleep_records.order(created_at: :desc)

      @pagy, @sleep_records = pagy(@sleep_records, page: params[:page] || 1, items: params[:per_page])
      render json: Api::SleepRecordSerializer.new(@sleep_records).as_json
    end

    # POST /api/users/:user_id/sleep_records
    def create
      @sleep_record = current_user.sleep_records.create!(sleep_record_params)

      render json: Api::SleepRecordSerializer.new(@sleep_record).as_json
    end

    private

    def sleep_record_params
      params.require(:sleep_record).permit(:start_time, :end_time)
    end
  end
end
