class RadioTracksController < ApplicationController

  def show
    if params[:track_title].blank?
      # no track specified
      if !current_track = RadioTrack.order('broadcast_date DESC').first
        return handle_error('no_item_found', 'Radiobeitrag')
      end
      return redirect_to_radio_track(current_track)
  	end
    @radio_tracks = RadioTrack.order('broadcast_date DESC').includes(:categories)
    @selected_track = get_selected_item(@radio_tracks, params[:track_title])

    # requested radio track unknown
    return handle_error('item_not_found', 'Radiobeitrag', params[:track_title]) if @selected_track.nil?

    @show_fb_like_button = true
    @content_section_column_width = get_content_column_width(@radio_tracks) 
    @audio_player = get_audio_player(@selected_track.source_url)
  end

private  

  def get_audio_player(source_url)
    audio_player = ''
    if source_url.present?
      array = source_url.split('audio_player=')
      audio_player = array[1]
    end
    return audio_player
  end

  def redirect_to_radio_track(radio_track)
    redirect_to :action => :show, :track_title => radio_track.url_title, :only_path => true
  end 
end
