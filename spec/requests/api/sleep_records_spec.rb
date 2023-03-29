require 'swagger_helper'

RSpec.describe 'api/sleep_records' do
  path '/api/users/{user_id}/sleep_records' do
    parameter name: :user_id, in: :path, type: :integer, description: 'user_id', example: 1

    get 'list sleep_records' do
      consumes 'application/json'
      produces 'application/json'

      parameter name: :page, in: :path, type: :integer, description: 'page', example: 1
      parameter name: :per_page, in: :path, type: :integer, description: 'per_page', example: 10

      response 200, 'successful' do
        pagination_headers
        let(:page) { 1 }
        let(:per_page) { 10 }
        let(:user_id) { create(:user).id }
        let(:sleep_records) { create_list(4, :sleep_record, user_id: user_id) }

        schema type: :object,
               properties: {
                 data: { type: :array, items: { '$ref': '#/components/sleep_records' } }
               }

        run_test!
      end
    end

    post 'create sleep_record' do
      consumes 'application/json'
      produces 'application/json'

      parameter name: :sleep_record_params, in: :body, schema: {
        type: :object,
        properties: {
          sleep_record: {
            type: :object,
            properties: {
              start_time: { type: :string, example: '23/03/2023 19:00' },
              end_time: { type: :string, example: '24/03/2023 19:00' }
            },
            required: %i[start_time end_time]
          }
        }
      }

      response 200, 'successful' do
        let(:user_id) { create(:user).id }

        let(:sleep_record_params) { { sleep_record: { start_time: '23/03/2023 19:00', end_time: '24/03/2023 19:00' } } }
        run_test!
      end
    end
  end
end
