# frozen_string_literal: true

module Api
  class FriendsController < BaseController
    before_action :set_current_user
    before_action :set_friend, only: %i[sleep_records]
    before_action :authorize_friend, only: :sleep_records
    after_action :paginate, only: %i[index sleep_records]

    # GET /api/users/:user_id/friends
    def index
      @friends = current_user.friends

      @pagy, @friends = pagy(@friends, page: params[:page] || 1, items: params[:per_page])
      render json: Api::UserSerializer.new(@friends).as_json
    end

    # GET /api/users/:user_id/friends/:friend_id/sleep_records
    def sleep_records
      @sleep_records = SleepRecord.past_n_days(@friend, 7).order_by_sleep_length

      @pagy, @sleep_records = pagy(@sleep_records, page: params[:page] || 1, items: params[:per_page])
      render json: Api::SleepRecordSerializer.new(@sleep_records).as_json
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
