# frozen_string_literal: true

module Api
  class FriendshipsController < BaseController
    before_action :set_current_user
    before_action :set_friendship, only: :destroy

    # POST /api/friendships
    def create
      @friendship = Friendship.new(friendship_params)

      if @friendship.save
        render json: @friendship, status: :created, location: @friendship
      else
        render json: @friendship.errors, status: :unprocessable_entity
      end
    end

    # DELETE /api/friendships/:id
    def destroy
      @friendship.destroy
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_friendship
      @friendship = Friendship.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def friendship_params
      params.require(:friendship).permit(:user_id, :friend_id)
    end
  end
end
