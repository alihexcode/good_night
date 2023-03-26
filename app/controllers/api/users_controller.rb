# frozen_string_literal: true

module Api
  class UsersController < BaseController
    after_action :paginate, only: :index

    # GET /api/users
    def index
      @users = User.all

      @pagy, @users = pagy(@users, page: params[:page] || 1, items: params[:per_page])
      render json: Api::UserSerializer.new(@users).as_json
    end
  end
end
