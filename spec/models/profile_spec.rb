require 'rails_helper'
# require_relative '../factories/profiles'



describe Profile do
  before { @profile = FactoryGirl.build(:profile) }

  subject { @profile }

  it { should respond_to(:name) }
  it { should respond_to(:geolocation) }
  it { should respond_to(:photo) }

  it { should be_valid }
end
