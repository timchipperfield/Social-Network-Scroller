FactoryGirl.define do
  factory :profile do
    name { Faker::Name.name }
    geolocation "12345678, 12345678"
    photo "fake_img_url"
  end
end
