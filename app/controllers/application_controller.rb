class ApplicationController < ActionController::Base
  protect_from_forgery

	before_filter :set_locale
  before_filter :set_locale_from_url

  protected

  # add locale to url if not supplied
  def add_locale_to_url
  	unless params[:locale]
      redirect_to eval("root_#{I18n.locale}_path")
    end
  end

  private

  def set_locale
  	I18n.locale = params[:locale] || I18n.default_locale
    # I18n.locale = params[:locale] || ((lang = request.env['HTTP_ACCEPT_LANGUAGE']) && lang[/^[a-z]{2}/])
  end
end
