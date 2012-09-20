class ApplicationController < ActionController::Base
  protect_from_forgery

	before_filter :set_locale
  before_filter :set_locale_from_url
  
  protected


  private

  def set_locale
    params_locale = params[:locale]
    language_locale = locale_from_accept_language
    default_locale = I18n.default_locale
    I18n.locale = params_locale || language_locale || default_locale

    if params_locale.blank?
      redirect_to "/#{I18n.locale}#{request.path_info}"
    end
  end

  def locale_from_accept_language
    accepted_lang = request.env['HTTP_ACCEPT_LANGUAGE']
    if (!accepted_lang.nil?)
      accepted_lang.scan(/^[a-z]{2}/).first
    else
      "de" #de is default!
    end
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
      if !item.short_title.nil?
        length = item.short_title.size
        if length > 25
          return true
        end
      end
    end
    return false 
  end
end
