require 'swagger_helper'

RSpec.describe 'Airport', type: :request do

  path '/api/v1/airports' do

    get 'Fetches Airports' do
      tags 'Airport'
      produces 'application/json'
      let!(:frankfurt_airport) { create(:airport, :fra) }
      let!(:zurich_airport) { create(:airport, :zrh) }

      parameter name: :'countries[]', in: :query, type: :string
      parameter name: :'page', in: :query, type: :string

      response '200', 'Airports found' do
        schema type: :object,
               properties: {
                 airports: { type: :array,
                             items: { type: :object,
                                      properties: {
                                        iata: { type: :string },
                                        name: { type: :string },
                                        country: { type: :string },
                                        id: { type: :string }
                                      },
                                      additionalProperties: false,
                                      required: %w[name iata country id]
                             } },
               },
               required: ['airports']


        let(:'countries[]') { "Switzerland" }
        let(:page) { "1" }
        run_test! do |response|
          expect(JSON.parse(response.body)["airports"].length).to eq(1)
        end
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
