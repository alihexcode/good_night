require 'swagger_helper'

RSpec.describe 'api/users' do
  path '/api/users' do
    get('list users') do
      response(200, 'successful') do
        consumes 'application/json'
        produces 'application/json'

        pagination_headers
        before { create_list(:user, 5) }

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
