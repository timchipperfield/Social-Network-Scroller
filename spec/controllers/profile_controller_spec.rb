require 'rails_helper'
require 'spec_helper'
require 'json'


RSpec.describe Api::V1::ProfilesController, type: :controller do

  describe "GET #index" do

    context "when there is one existing profile" do

      before(:each) do
        @profile = FactoryGirl.create(:profile, name: "Tim Chipperfield", geolocation: "51.51734, -0.0732808" )
      end

      it "index has correct profile information" do
        get :index, :format => :json
        expect(response.body).to include("Tim Chipperfield")
        expect(response.body).to include("51.51734, -0.0732808")
        expect(response.body).to include("fake_img_url")
      end

      it "provides the profiles as a JSON" do
        get :index, :format => :json
        expect(response.status).to eq 200
        expect(response.header['Content-Type']).to include("application/json")
      end

    end

    context "when handling multiple profles" do

      before(:each) do
      FactoryGirl.create_list(:profile, 25)
      end

      it "has the paginated amount of profiles" do
        get :index, :format => :json
        expect(JSON.parse(response.body).count).to eq 10
      end

      it "can visit a second page" do
        get :index, :format => :json, :params => {:page => 1}
        first_results = response.body
        get :index, :format => :json, :params => {:page => 2}
        expect(response.body).not_to eq(first_results)
      end

    end

  end

end
