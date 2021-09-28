require 'rails_helper'

RSpec.describe "API::V1::Airports", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/api/v1/airports/"
      expect(response).to have_http_status(:success)
    end

    it "filters airports based on countries" do
      create(:airport, :fra)
      zurich_airport = create(:airport, :zrh)
      get "/api/v1/airports?countries[]=Switzerland"
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)["airports"]).to contain_exactly({
                                                             "id" => zurich_airport.id,
                                                             "country" => "Switzerland",
                                                             "iata" => "ZRH",
                                                             "name" => "Zurich Airport"
                                                           })
    end

    it "returns paginated results" do
      create(:airport, :fra)
      create(:airport, :zrh)
      get "/api/v1/airports"
      expect(response).to have_http_status(:success)
      expect(response.headers["Current-Page"]).to eq("1")
      expect(response.headers["Page-Items"]).to eq("20")
      expect(response.headers["Total-Count"]).to eq("2")
      expect(response.headers["Total-Pages"]).to eq("1")
    end

    it "returns relevant airports first" do
      frankfurt_airport = create(:airport, :fra, passenger_volume: 1000)
      zurich_airport = create(:airport, :zrh, passenger_volume: 2000)
      munich_airport = create(:airport, :muc, passenger_volume: nil)
      get "/api/v1/airports"
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)["airports"][0]["id"]).to eq(zurich_airport.id)
      expect(JSON.parse(response.body)["airports"][1]["id"]).to eq(frankfurt_airport.id)
      expect(JSON.parse(response.body)["airports"][2]["id"]).to eq(munich_airport.id)
      expect(JSON.parse(response.body)["airports"].length).to eq(3)
    end

  end

end
