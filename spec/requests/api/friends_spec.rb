require 'swagger_helper'

RSpec.describe 'api/friends' do
  path '/api/users/{user_id}/friends/sleep_records' do
    get 'sleep_records friend' do
      consumes 'application/json'
      produces 'application/json'

      parameter name: :user_id, in: :path, type: :integer, description: 'user_id', example: 1
      parameter name: :page, in: :path, type: :integer, description: 'page', example: 1
      parameter name: :per_page, in: :path, type: :integer, description: 'per_page', example: 10

      response 200, 'successful' do
        pagination_headers
        before { create(:friendship, user_id: user_id, friend_id: friend_id) }

        let(:user_id) { create(:user).id }
        let(:friend_id) { create(:user).id }
        let(:sleep_records) { create_list(:sleep_record, user_id: friend_id) }
        let(:page) { 1 }
        let(:per_page) { 10 }

        schema type: :object,
               properties: {
                 data: { type: :array, items: { '$ref': '#/components/sleep_records' } }
               }
        run_test!
      end
    end
  end

  path '/api/users/{user_id}/friends' do
    get 'List friend' do
      consumes 'application/json'
      produces 'application/json'

      parameter name: :page, in: :path, type: :integer, description: 'page', example: 1
      parameter name: :per_page, in: :path, type: :integer, description: 'per_page', example: 10
      parameter name: :user_id, in: :path, type: :integer, description: 'user_id', example: 1

      response 200, 'successful' do
        pagination_headers
        before { create(:friendship, user_id: user_id, friend_id: friend_id) }

        let(:user_id) { create(:user).id }
        let(:friend_id) { create(:user).id }
        let(:page) { 1 }
        let(:per_page) { 10 }

        schema type: :object,
               properties: {
                 data: { type: :array, items: { '$ref': '#/components/user' } }
               }
        run_test!
      end
    end
  end
end
