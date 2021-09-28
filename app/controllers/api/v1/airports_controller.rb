module API
  module V1
    class AirportsController < BaseController
      after_action { pagy_headers_merge(@pagy) if @pagy }
      def index
        airports = Airport.filter(filter_params)
        @pagy, @records = pagy(airports)
        render json: { airports: AirportSerializer.render_as_hash(@records) }
      end

      private def filter_params
        params.permit(countries: [])
      end
    end
  end
end