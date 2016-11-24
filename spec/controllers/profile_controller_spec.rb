require 'rails_helper'
require 'spec_helper'
require 'json'


RSpec.describe Api::V1::ProfilesController, type: :controller do

  describe "GET #index" do

    context "when there is an existing profile" do

      before(:each) do
        @profile = Profile.create(name: "Tim Chipperfield", geolocation: "51.51734, -0.0732808", photo: "image_url")
      end

      it "index has all existing profiles" do
        get :index
        expect(assigns(:profiles)).to include("Tim Chipperfield")
      end

      it "provides the profiles as a JSON" do
        get :index
        expect(response.status).to eq 200
        profiles = assigns(:profiles)
        expect(JSON.parse(profiles)).to be_instance_of(Array)
      end

    end
  end

end
