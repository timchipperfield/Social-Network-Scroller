require 'rails_helper'

feature "Views: Index page with profiles" do

  context "accessing the page" do
    it "has visible html content" do
      visit "/"
      expect(page).to have_content("Profiles")
    end
  end

  context "with existing profiles" do
    before(:each) do
      FactoryGirl.create_list(:profile, 25)
    end

    it "shows profiles" do
      visit "/"
      expect(page).to have_css('div#profile')
    end

    it "can paginate with the next data set" do
      visit "/"
      click_link("Next")
      expect(page).to have_css('div#profile')
    end
  end

end
