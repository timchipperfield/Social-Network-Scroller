module Api::V1

  class API::V1::ProfilesController < ApiController
    respond_to :json

    def index
      @profiles = Profiles.all
      render :json @profiles
    end
  end

end
