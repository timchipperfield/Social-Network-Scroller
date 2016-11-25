module Api::V1

  class ProfilesController < ApiController

    def index
      @profiles = Profile.all.paginate(page: params[:page], per_page: 10).order('id DESC')
      render_with_formatting
    end

    def show
    end

    private

    def render_with_formatting
      respond_to do |format|
        format.html
        format.js
        format.json { render json: @profiles }
      end
    end

  end

end
