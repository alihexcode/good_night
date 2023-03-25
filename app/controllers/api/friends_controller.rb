# frozen_string_literal: true

module Api
  class FriendsController < BaseController
    before_action :set_current_user
    before_action :set_friend, only: %i[sleep_records show]
    before_action :authorize_friend, only: :sleep_records

    # GET /api/users/:user_id/friends
    def index
      @friends = current_user.friends

      render json: @friends
    end

    # GET /api/users/:user_id/friends/:friend_id/sleep_records
    def sleep_records
      @sleep_records = SleepRecord.past_n_days(@friend, 7).order_by_sleep_length

      render json: @sleep_records
    end

    # GET /api/users/:user_id/friends/:id
    def show
      render json: @friend
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
