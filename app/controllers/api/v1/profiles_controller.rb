module Api::V1

  class API::V1::ProfilesController < ApiController
    

    def index
      @profiles = Profile.all
      render json: @profiles
    end
  end

end
