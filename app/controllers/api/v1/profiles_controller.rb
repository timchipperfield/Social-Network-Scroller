module Api::V1

  class ProfilesController < ApiController

    def index
      @profiles = Profile.all.paginate(page: params[:page], per_page: 10).order('id DESC')
      render_ajax_or_sync
    end

    def show
    end

    private

    def render_ajax_or_sync
      if request.xhr?
          render_partial
      else
        render_sync
      end
    end

    def render_sync
      respond_to do |format|
        format.html { render 'index' }
        format.js { render 'profile_pagination' }
        format.json { render json: @profiles }
      end
    end

    def render_partial
      respond_to do |format|
        format.html  { render :partial => 'my_profiles'}
        format.js { render 'profile_pagination' }
        format.json { render json: @profiles }
      end
    end

  end

end
