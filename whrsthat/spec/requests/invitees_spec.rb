require 'rails_helper'

RSpec.describe "Invitees", type: :request do
  describe "GET /invitees" do
    it "works! (now write some real specs)" do
      get invitees_path
      expect(response).to have_http_status(200)
    end
  end
end
