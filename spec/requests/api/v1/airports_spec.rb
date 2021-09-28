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

  end

end
