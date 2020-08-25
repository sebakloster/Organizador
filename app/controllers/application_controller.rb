class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :authenticate_user!

  def set_locale
    I18n.locale = 'es'
  end

  rescue_from CanCan::AccessDenied do |_exception|
    redirect_to root_path
  end
end
