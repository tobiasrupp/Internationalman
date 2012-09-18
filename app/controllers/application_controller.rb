class ApplicationController < ActionController::Base
  protect_from_forgery

	before_filter :set_locale
  before_filter :set_locale_from_url
  
  protected


  private

  # add locale to url if not supplied
  def add_locale_to_url
    unless params[:locale]
      redirect_to eval("root_#{I18n.locale}_path")
    end
  end

  def set_locale
  	I18n.locale = params[:locale] || I18n.default_locale
    logger.debug "* Locale set to '#{I18n.locale}'"
    # I18n.locale = params[:locale] || ((lang = request.env['HTTP_ACCEPT_LANGUAGE']) && lang[/^[a-z]{2}/])
  end

  def set_status_message
    @status_message = StatusMessage.find(:first,
                :order => "id DESC")
  end

  def long_titles?(items)
    if items.nil? or items.count == 0
      return false
    end
    items.each do |item|
      length = item.short_title.size
      if length > 25
        return true
      end
    end
    return false 
  end
end
