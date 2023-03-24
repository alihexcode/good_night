# frozen_string_literal: true

module Api
  class FriendsController < BaseController
    before_action :set_current_user

    # GET /api/users/:user_id/friends
    def index
      @users = current_user.friends

      render json: @users
    end

    # GET /api/users/:user_id/friends/:id
    def show
      render json: @friendship
    end
  end
end
