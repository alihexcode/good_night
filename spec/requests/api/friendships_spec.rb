require 'swagger_helper'

RSpec.describe 'api/friendships' do
  path '/api/users/{user_id}/friendships/{friend_id}/unfriend' do
    parameter name: :user_id, in: :path, type: :integer, description: 'user_id', example: 1
    parameter name: :friend_id, in: :path, type: :integer, description: 'friend_id', example: 2

    delete 'unfriend friendship' do
      response 204, 'successful' do
        before { create(:friendship, user_id: user_id, friend_id: friend_id) }

        let(:user_id) { create(:user).id }
        let(:friend_id) { create(:user).id }

        run_test!
      end
    end
  end

  path '/api/users/{user_id}/friendships/{friend_id}/add_friend' do
    parameter name: :user_id, in: :path, type: :integer, description: 'user_id', example: 1
    parameter name: :friend_id, in: :path, type: :integer, description: 'friend_id', example: 2

    post 'add_friend friendship' do
      response 201, 'created' do
        let(:user_id) { create(:user).id }
        let(:friend_id) { create(:user).id }

        schema type: :object,
               properties: {
                 data: { '$ref': '#/components/friendship' }
               }

        run_test!
      end
    end
  end
end
