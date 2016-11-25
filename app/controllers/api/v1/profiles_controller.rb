module Api::V1

  class ProfilesController < ApiController

    def index
      @profiles = Profile.all.paginate(page: params[:page], per_page: 10).order('id DESC')
      if request.xhr?
          render_partial
      else
        render_with_formatting
      end

    end

    def show
    end

    private

    def render_with_formatting
      respond_to do |format|
        format.html { render 'index' }
        format.js { render 'profile_pagination' }
        format.json { render json: 'profile_page' }
      end
    end

    def render_partial
      respond_to do |format|
        format.html  { render :partial => 'my_profiles'}
        format.js { render 'profile_pagination' }
      end
    end

  end

end
