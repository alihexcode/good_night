# frozen_string_literal: true

module Api
  class BaseController < ActionController::API
    include Pundit
    include Pagy::Backend
    include HeaderPagination

    # Gets the current signed-in user based on the user_id parameter.
    attr_reader :current_user

    rescue_from ActiveRecord::RecordNotFound, with: :base_render_record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :base_render_unprocessable_entity
    rescue_from ActiveRecord::RecordNotUnique, with: :base_render_record_not_unique
    rescue_from Pundit::NotAuthorizedError, with: :base_render_unauthorized_error
    rescue_from ArgumentError, with: :base_render_exeption_error

    private

    def base_render_record_not_found(exception)
      render json: { message: exception.message }, status: :not_found
    end

    def base_render_unprocessable_entity(exception)
      render json: { message: exception.record.errors.full_messages.to_sentence }, status: :unprocessable_entity
    end

    def base_render_exeption_error(exception)
      render json: { message: exception.message }, status: :unprocessable_entity
    end

    def base_render_unauthorized_error(_exception)
      render json: { message: I18n.t('errors.unauthorized_error') }, status: :unauthorized
    end

    def base_render_record_not_unique
      render json: { message: I18n.t('errors.record_not_uniq_error') }, status: :forbidden
    end

    # Sets the current_user instance variable based on the user_id parameter.
    # Assumes that the user has already been authenticated and the user_id is valid.
    def set_current_user
      @current_user = User.find(params[:user_id])
    end

    def paginate
      pagination_headers(@pagy)
    end
  end
end
