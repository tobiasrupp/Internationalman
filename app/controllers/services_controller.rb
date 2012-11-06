class ServicesController < ApplicationController
  
	before_filter :authenticate_admin_user!, :except => [:get_facebook_items_to_refresh]

  def get_facebook_items_to_refresh
    return if params[:days].blank?
    
    @log = FacebookUtility.new.items_to_refresh(params[:days])
    render(:layout => false)
  end

  def refresh_facebook_data_remote
    return if params[:days].blank? and params[:url].blank?
     
    facebook_utility = FacebookUtility.new
    ok = facebook_utility.refresh_like_button_data(params[:days], params[:url])
    @records_updated = facebook_utility.records_updated
    @log = facebook_utility.log

    handle_message(ok, @records_updated)
    render(:layout => 'pages')
  end

private

  def handle_message(ok, records_updated)
    if ok == true
      flash.now[:notice] = "Completed successfully. Records updated: #{records_updated}"
    else
      flash.now[:error] = "Completed with errors."
    end
  end
end
