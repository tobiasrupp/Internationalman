class ServicesController < ApplicationController
  
	before_filter :authenticate_admin_user!, :except => [:get_facebook_items_to_refresh]

  def get_facebook_items_to_refresh
    return if params[:days].blank?
    
    @log = FacebookUtility.new.items_to_refresh(params[:days])
    render(:layout => false)
  end

  def refresh_facebook_data_remote
    if !params[:refresh_all] and !params[:days] and !params[:url]
      return
    end

    @records_updated = 0
    @log = ""
    error = false
    error_occurred = false
    if params[:url]
      url = params[:url]
      if Rails.env.test?
        # mock get request in test environment
        code = 200
      else 
        response = RestClient.get('http://developers.facebook.com/tools/debug/og/object', :params => {:q => url })
        code = response.code
      end
      error = get_response_code_message(code, url)
    else
      items = []
      if Rails.env.test?
        # mock get request in test environment, get data from local development environment
        request_root_url = "http://localhost:3001"
      else 
        request_root_url = "http://www.international-man.net"
      end
        items = RestClient.get("#{request_root_url}/de/get_facebook_items_to_refresh", :params => {:days => params[:days], :get_all => params[:refresh_all]})
      items.gsub!(/[\[\]]/,'')
      urls = items.split(', ')
      urls.each do |url|
        url.gsub!(/\A"|"\Z/, '')
        if Rails.env.test?
          # mock get request in test environment
          code = 200
        else 
          response = RestClient.get('http://developers.facebook.com/tools/debug/og/object', :params => {:q => url })
          code = response.code
        end
        error_occurred = get_response_code_message(code, url)
        if error_occurred == true
          error = true
        end
      end
    end
    if error == true
      flash.now[:error] = "Completed with errors."
    else
      flash.now[:notice] = "Completed successfully. Records updated: #{@records_updated}"
    end
    render(:layout => 'pages')
  end

private

  def get_response_code_message(code, url)
    case code
      when 200...207
        logger.debug "*** Success #{response.code} (#{url})."
        @log = @log + "Success #{response.code} (#{url})" + "<br>"
        @records_updated = @records_updated + 1
      when 404
        logger.debug "*** ERROR #{response.code} (#{url})."
        @log = @log + "ERROR #{response.code} (#{url})" + "<br>"
        error = true
      when 500...600
        logger.debug "*** ERROR #{response.code} (#{url})."
        @log = @log + "ERROR #{response.code} (#{url})" + "<br>"
        error = true
      else
        logger.debug "*** ERROR #{response.code} (#{url})."
        @log = @log + "ERROR #{response.code} (#{url})" + "<br>"
        error = true
    end
  end 
end
