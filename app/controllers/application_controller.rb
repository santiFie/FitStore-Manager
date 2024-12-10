class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  rescue_from CanCan::AccessDenied do |exception|
    render "errors/403", status: 403, layout: false
    return
  end

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render "errors/404", status: 404, layout: false
  end

  rescue_from StandardError do |exception|
    Rails.logger.error exception
    render "errors/500", status: 500, layout: false
  end
end
