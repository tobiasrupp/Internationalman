ActiveAdmin.register Video do
   index do
    column :title
    column :url_title
    column "Categories" do |video|
  		video.categories.map { |p| p.name }.join('<br />').html_safe
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
  		f.input :country, :priority_countries => []
  		f.input :author
  		f.input :duration
      f.input :categories
      f.input :longitude
      f.input :latitude
      f.input :broadcast_date, :start_year => Date.today.year - 15, :end_year => Date.today.year + 1
      f.input :broadcaster
      f.input :filename
      f.input :source_url
      f.input :embed_code
      f.input :web_page
    end
    f.buttons
  end
	show do |video|
    div :class => 'panel' do
      h3 'Video Details'
      div :class => 'panel_contents' do
        div :class => 'attributes_table video' do
          table do
          	tr do
              th { 'ID' }
              td { video.id }
            end
            tr do
              th { 'Title' }
              td { video.title }
            end
            tr do
              th { 'Short Title' }
              td { video.short_title }
            end
            tr do
              th { 'Url Title' }
              td { video.url_title }
            end
            tr do
              th { 'Language' }
              td { video.language }
            end
            tr do
              th { 'Country' }
              td { video.country }
            end
						tr do
              th { 'Author' }
              td { video.author }
            end
            tr do
              th { 'Duration' }
              td { video.duration }
            end
            tr do
              th { 'Categories' }
              td { video.categories.map { |p| p.name }.join(', ') }
            end
            tr do
              th { 'Longitude' }
              td { video.longitude }
            end
            tr do
              th { 'Latitude' }
              td { video.latitude }
            end
            tr do
              th { 'Broadcast Date' }
              td { video.broadcast_date }
            end
            tr do
              th { 'Broadcaster' }
              td { video.broadcaster }
            end
            tr do
              th { 'Filename' }
              td { video.filename }
            end
            tr do
              th { 'Web Page' }
              td { video.web_page }
            end
            tr do
              th { 'Source URL' }
              td { video.source_url }
            end
            tr do
              th { 'Embed Code' }
              td { video.embed_code }
            end
            tr do
              th { 'Created At' }
              td { video.created_at }
            end
            tr do
              th { 'Updated At' }
              td { video.updated_at }
            end
          end # table
        end # attributes_table
      end # panel_contents
    end # panel
  end # show
end
