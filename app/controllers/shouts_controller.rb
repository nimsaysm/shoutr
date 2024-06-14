class ShoutsController < ApplicationController
    def create 
        shout = current_user.shouts.create(shouts_params)
        redirect_to root_path, redirect_options_for(shout)
    end

    def show
        @shout = Shout.find(params[:id])
    end

    private
    
    def shouts_params
        { content: content_form_params }
    end

    def content_form_params
      case params[:shout][:content_type]
        when "TextShout" then TextShout.new(text_shout_content_params)
        when "PhotoShout" then PhotoShout.new(photo_shout_content_params)
      end
    end

    def text_shout_content_params
      params.require(:shout).require(:content).permit(:body)
    end

    def photo_shout_content_params
        params.require(:shout).require(:content).permit(:image)
    end

    def redirect_options_for(shout)
        if shout.persisted?
            { notice: "Shouted successfuly" }
        else
            { alert: "Could not shout" }
        end
    end
end