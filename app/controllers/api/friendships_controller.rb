# frozen_string_literal: true

module Api
  class FriendshipsController < BaseController
    before_action :set_current_user
    before_action :set_friendship, only: :unfriend

    # POST /api/users/:user_id/friendships/:friend_id/add_friend
    def add_friend
      @friendship = Friendship.create!(friendship_params)

      render json: Api::FriendshipSerializer.new(@friendship).as_json, status: :created
    end

    # DELETE /api/users/:user_id/friendships/:friend_id/unfriend
    def unfriend
      @friendship.destroy
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_friendship
      @friendship = current_user.friendships.find_by(friend_id: params[:friend_id])
      return if @friendship

      raise ActiveRecord::RecordNotFound,
            I18n.t('activerecord.errors.messages.friendship_not_found', user_id: current_user.id, friend_id: params[:friend_id])
    end

    # Only allow a list of trusted parameters through.
    def friendship_params
      params.require(:friendship).permit(:user_id, :friend_id)
    end
  end
end
