class ApplicationController < ActionController::Base
  before_action :authenticate_customer!, except: [:top,:about], unless: :admin_url
  before_action :authenticate_admin!, if: :admin_url 
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  def admin_url
  request.fullpath.include?("/admin")
  end
  
  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admin_path
    when Customer
      root_path
    end
  end
  
  def after_sign_out_path_for(resource)
    root_path
  end
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name,:first_name,:furigana_last_name,:furigana_first_name,:post_code,:address,:tel_number])
  end  
end
