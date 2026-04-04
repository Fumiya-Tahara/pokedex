require "rails_helper"

RSpec.describe "Pokemons", type: :request do
  describe "GET /" do
    subject { get "/" }

    context "when accessing the root path" do
      it "returns http 200" do
        subject
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
