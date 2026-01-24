class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?

    def after_sign_in_path_for(resource)
      stored = stored_location_for(resource)

      return recipes_path if stored == root_path
      
      stored || recipes_path
      
    end

    private

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :profile, :image])
      devise_parameter_sanitizer.permit(:account_update, keys: [:username, :profile, :image])
    end
end
