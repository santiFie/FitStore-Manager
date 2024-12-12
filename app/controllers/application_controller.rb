class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern


  rescue_from CanCan::AccessDenied do |exception|
    if current_user.nil?
      flash[:alert] = "Debe iniciar sesión para acceder a esta página"
      redirect_to new_user_session_path, alert: "Debe iniciar sesión para acceder a esta página"
    else
      render "errors/403", status: forbidden, layout: false
    end
  end

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render "errors/404", status: not_found, layout: false
  end

  # rescue_from StandardError do |exception|
  #   Rails.logger.error exception
  #   render "errors/500", status: :internal_server_error, layout: false
  # end
end
