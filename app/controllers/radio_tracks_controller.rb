class RadioTracksController < ApplicationController
 
  before_filter :set_status_message

  def show
    # add_locale_to_url
    
  	# get all radio tracks to display them in 2. level navigation list sorted by broadcast date descending
		@radio_tracks = RadioTrack.find(:all,
	              :include => :categories,
	              :order => "broadcast_date DESC")
    if @radio_tracks.count == 0
      flash.now[:notice] = "Kein Radiobeitrag gefunden."
      return
    end
		# display details of current radio track in content section
    if params[:track_title]
    	@radio_tracks.each do |track|
    		if track.url_title == params[:track_title]
    			@selected_track = track
    		end	
    	end
      if @selected_track.nil?
        # requested radio track unknown
        flash.now[:error] = "Radiobeitrag '#{params[:track_title]}' wurde nicht gefunden."
      end
    else	
    	@selected_track = @radio_tracks[0]
  	end
  end
end
