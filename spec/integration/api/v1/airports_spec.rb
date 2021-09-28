require 'swagger_helper'

RSpec.describe 'Airport', type: :request do

  path '/api/v1/airports' do

    get 'Fetches Airports' do
      tags 'Airport'
      produces 'application/json'

      response '200', 'Airports found' do
        schema type: :object,
               properties: {
                 airports: { type: :array,
                             items: { type: :object,
                                      properties: {
                                        name: { type: :string },
                                        city: { type: :string },
                                        country: { type: :string },
                                        id: { type: :string }
                                      },
                                      required: %w[name city country id]
                             } },
               },
               required: ['airports']

        run_test!
      end

      # response '404', 'blog not found' do
      #   let(:id) { 'invalid' }
      #   run_test!
      # end
      #
      # response '406', 'unsupported accept header' do
      #   let(:'Accept') { 'application/foo' }
      #   run_test!
      # end
    end
  end

end
