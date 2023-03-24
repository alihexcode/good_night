# frozen_string_literal: true

module Api
  class SleepRecordsController < BaseController
    before_action :set_current_user
    before_action :set_friend
    before_action :authorize_friend, only: [:index]

    # GET /sleep_records
    def index
      @sleep_records = SleepRecord.all

      render json: @sleep_records
    end

    private

    def set_friend
      @friend = User.find(params[:friend_id])
    end

    def authorize_friend
      authorize @friend, :friend?
    end
  end
end
