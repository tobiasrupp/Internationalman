ActiveAdmin.register Video do
   index do
    column :id
    column :title
    column :short_title
    column "Categories" do |video|
  		video.categories.map { |p| p.name }.join('<br />').html_safe
		end
    column :broadcast_date
    column "Copyr.", :copyright_cleared
    column "Lang.", :language
		default_actions
  end

  filter :title, :as => :string
  filter :short_title, :as => :string
  filter :url_title, :as => :string
  filter :copyright_cleared, :as => :select
  filter :ctry, :as => :string, :label => "Country"
  filter :categories_id, :as => :check_boxes, :collection => proc {Category.all}
  
 # language switch - edit page
  action_item :only => :edit do
    link_to "Switch To German", edit_admin_video_de_path
  end
  action_item :only => :edit do
    link_to "Switch To English", edit_admin_video_en_path
  end

  # language switch - new page
  action_item :only => :new do
    link_to "Switch To German", new_admin_video_de_path
  end
  action_item :only => :new do
    link_to "Switch To English", new_admin_video_en_path
  end

# language switch - index page
  action_item :only => :index do
    link_to "Switch To German", admin_videos_de_path
  end
  action_item :only => :index do
    link_to "Switch To English", admin_videos_en_path
  end

  # language switch - show page
  action_item :only => :show do
    link_to "Switch To German", admin_video_de_path
  end
  action_item :only => :show do
    link_to "Switch To English", admin_video_en_path
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
      # f.input :filename
      f.input :embed_code, :input_html => { :class => 'autogrow', :rows => 10, :cols => 20 }, :hint => t(:translation_field)
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
              th { 'Language' }
              td { video.language }
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
              th { 'Country' }
              td { video.ctry }
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
              th { 'Embed Code' }
              td { video.embed_code }
            end
            tr do
              th { 'Source URL' }
              td { video.source_url }
            end
            tr do
              th { 'Copyright Cleared' }
              td { video.copyright_cleared }
            end
             tr do
              th { 'Address' }
              td { video.address }
            end
            tr do
              th { 'Gmaps' }
              td { video.gmaps }
            end
            tr do
              th { 'Longitude' }
              td { video.lon }
            end
            tr do
              th { 'Latitude' }
              td { video.lat }
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
