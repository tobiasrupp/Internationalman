ActiveAdmin.register RadioTrack do
  index do
    column :id
    column :title
    column :short_title
    # column :url_title
    column "Categories" do |radio_track|
  		radio_track.categories.map { |p| p.name }.join('<br />').html_safe
		end
    column :broadcast_date
    column "Copyr.", :copyright_cleared
    column "Lang.", :language
		default_actions
  end

  # language switch - edit page
  action_item :only => :edit do
    link_to "Switch To German", edit_admin_radio_track_de_path
  end
  action_item :only => :edit do
    link_to "Switch To English", edit_admin_radio_track_en_path
  end

  # language switch - new page
  action_item :only => :new do
    link_to "Switch To German", new_admin_radio_track_de_path
  end
  action_item :only => :new do
    link_to "Switch To English", new_admin_radio_track_en_path
  end

# language switch - index page
  action_item :only => :index do
    link_to "Switch To German", admin_radio_tracks_de_path
  end
  action_item :only => :index do
    link_to "Switch To English", admin_radio_tracks_en_path
  end

  # language switch - show page
  action_item :only => :show do
    link_to "Switch To German", admin_radio_track_de_path
  end
  action_item :only => :show do
    link_to "Switch To English", admin_radio_track_en_path
  end

  form do |f|
    f.inputs do
      f.input :language, :input_html => { :readonly => true, :value => I18n.locale}, :hint => "Read-only"
       f.input :title, :required => true, :input_html => { :size => 255 }, :hint => t(:translation_field)
      f.input :short_title, :required => true, :input_html => { :size => 80 }, :hint => t(:translation_field)
      f.input :url_title, :required => true, :hint => "#{t(:translation_field)}; Beispiel: mein-neuer-blog-eintrag", :input_html => { :size => 80 }
  		f.input :ctry, :label => "Country", :hint => t(:translation_field)
  		f.input :author
  		f.input :duration
      f.input :categories
      f.input :broadcast_date, :start_year => Date.today.year - 15, :end_year => Date.today.year + 1
      f.input :broadcaster
      f.input :source_url, :hint => t(:translation_field)
      f.input :copyright_cleared, :as => :radio
      f.input :web_page, :hint => t(:translation_field)
      f.input :address
      f.input :gmaps, :label => t(:geocoding_found)
      f.input :lon, :label => "Longitude"
      f.input :lat, :label => "Latitude"
    end
    f.buttons
  end
	show do |radio_track|
    div :class => 'panel' do
      h3 'Radio Track Details'
      div :class => 'panel_contents' do
        div :class => 'attributes_table radio_track' do
          table do
          	tr do
              th { 'ID' }
              td { radio_track.id }
            end
            tr do
              th { 'Language' }
              td { radio_track.language }
            end
            tr do
              th { 'Title' }
              td { radio_track.title }
            end
            tr do
              th { 'Short Title' }
              td { radio_track.short_title }
            end
            tr do
              th { 'Url Title' }
              td { radio_track.url_title }
            end
            tr do
              th { 'Country' }
              td { radio_track.ctry }
            end
						tr do
              th { 'Author' }
              td { radio_track.author }
            end
            tr do
              th { 'Duration' }
              td { radio_track.duration }
            end
            tr do
              th { 'Categories' }
              td { radio_track.categories.map { |p| p.name }.join(', ') }
            end
            tr do
              th { 'Broadcast Date' }
              td { radio_track.broadcast_date }
            end
            tr do
              th { 'Broadcaster' }
              td { radio_track.broadcaster }
            end
            tr do
              th { 'Filename' }
              td { radio_track.filename }
            end
            tr do
              th { 'Web Page' }
              td { radio_track.web_page }
            end
            tr do
              th { 'Source URL' }
              td { radio_track.source_url }
            end
            tr do
              th { 'Copyright Cleared' }
              td { radio_track.copyright_cleared }
            end
            tr do
              th { 'Address' }
              td { radio_track.address }
            end
            tr do
              th { 'Gmaps' }
              td { radio_track.gmaps }
            end
            tr do
              th { 'Longitude' }
              td { radio_track.lon }
            end
            tr do
              th { 'Latitude' }
              td { radio_track.lat }
            end
            tr do
              th { 'Created At' }
              td { radio_track.created_at }
            end
            tr do
              th { 'Updated At' }
              td { radio_track.updated_at }
            end
          end # table
        end # attributes_table
      end # panel_contents
    end # panel
  end # show
end
