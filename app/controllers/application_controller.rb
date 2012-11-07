class ApplicationController < ActionController::Base
  protect_from_forgery

	before_filter :set_locale

  private

  # def present(object, klass = nil)
  #   klass ||= "#{object.class}Presenter".constantize
  #   klass.new(object, view_content)
  # end

  def set_locale(locale = nil)
    params_locale = params[:locale]
    language_locale = locale_from_accept_language
    default_locale = I18n.default_locale
    I18n.locale = locale || params_locale || language_locale || default_locale
    logger.debug "*** Locale set to '#{I18n.locale}'"
    if params_locale.blank? and locale.blank?
      # redirect_to :locale => I18n.locale, :only_path => true
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

  def get_selected_item(items, requested_item)
    selected_item = nil
    items.each do |item|
      if item.url_title == requested_item
        selected_item = item
      end 
    end
    return selected_item
  end 

  def get_content_column_width(items)
    return 5 if long_titles?(items) 
    return 6
  end  

  def handle_error(reason, item_text = nil, variable = nil)
    case reason
      when 'no_item_found'
        flash.now[:notice] = "Kein #{item_text} gefunden."
      when 'item_not_found'  
        flash.now[:error] = "#{item_text} '#{variable}' wurde nicht gefunden."
    end
  end  

  def get_media_player(source_url, param_name)
    media_player = ''
    s = param_name + '='
    if source_url.present?
      array = source_url.split(s)
      media_player = array[1]
    end
    return media_player
  end
  
end
