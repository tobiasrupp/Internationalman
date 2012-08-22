ActiveAdmin.register RadioTrack do
  index do
    column :title
    column :author
    column "Categories" do |radio_track|
  		radio_track.categories.map { |p| p.name }.join('<br />').html_safe
		end
    column :broadcast_date
		default_actions
  end

  form do |f|
    f.inputs do
      f.input :title
      f.input :short_title
      f.input :url_title
      f.input :language
  		f.input :country
  		f.input :author
  		f.input :duration
      f.input :categories
      f.input :longitude
      f.input :latitude
      f.input :broadcast_date
      f.input :broadcaster
      f.input :filename
      f.input :source_url
      f.input :web_page
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
              th { 'Language' }
              td { radio_track.language }
            end
            tr do
              th { 'Country' }
              td { radio_track.country }
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
              th { 'Longitude' }
              td { radio_track.longitude }
            end
            tr do
              th { 'Latitude' }
              td { radio_track.latitude }
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
