module Api::V1

  class ProfilesController < ApiController


    def index
      profiles = Profile.all
      @profiles = profiles.to_json
    end
  end

end
