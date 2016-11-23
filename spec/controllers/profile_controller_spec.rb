require 'rails_helper'
require 'spec_helper'
require 'json'
require_relative '../../app/controllers/api/v1/profiles_controller'

  describe "Subdomain", :js => true do

    context "accessing the subdomain" do

      before(:each) do
        @controller = API::V1::ProfilesController.new
        @profile = Profile.create(name: "Tim Chipperfield", geolocation: "51.51734, -0.0732808", photo: "image_url")
      end

      it "is possible to access" do
        switch_to_subdomain("api")
        expect(get 'index').to have_http_status(200)
      end

    end
  end

  describe "getting the profiles", :js => true do

    before(:each) do
      @controller = API::V1::ProfilesController.new
      @profile = Profile.create(name: "Tim Chipperfield", geolocation: "51.51734, -0.0732808", photo: "image_url")
    end

    context "when there are existing profiles" do
      it "will return the list of profiles" do
        switch_to_subdomain("api")
        get 'index'
        expect(response.body).to include("Tim Chipperfield")
      end

      #  expect(profiles(response.body)).to include("Tim Chipperfield")
    end
  end
