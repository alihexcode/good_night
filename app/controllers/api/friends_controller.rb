# frozen_string_literal: true

module Api
  class FriendsController < BaseController
    before_action :set_current_user
    after_action :paginate, only: %i[index sleep_records]

    # GET /api/users/:user_id/friends
    def index
      @friends = current_user.friends

      @pagy, @friends = pagy(@friends, pagy_options)
      render json: Api::UserSerializer.new(@friends).as_json
    end

    # GET /api/users/:user_id/friends/sleep_records
    def sleep_records
      @sleep_records = SleepRecord.includes(:user).of_friends(current_user).past_n_days(7).order_by_sleep_length

      @pagy, @sleep_records = pagy(@sleep_records, pagy_options)
      render json: Api::SleepRecordSerializer.new(@sleep_records, include: [:user]).as_json
    end
  end
end
