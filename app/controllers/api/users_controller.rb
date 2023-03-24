# frozen_string_literal: true

module Api
  class UsersController < BaseController
    # GET /api/users
    def index
      @users = User.all

      render json: @users
    end
  end
end
