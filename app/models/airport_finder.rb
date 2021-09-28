class AirportFinder < BaseStruct
  attribute :filter_params, Types::Hash

  def call
    Airport.filter(filter_params).order("passenger_volume DESC NULLS LAST")
  end

end
