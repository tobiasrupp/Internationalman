ActiveAdmin.register Article do 
  scope :corporate_articles
	index do
		column :id
    column :title
    column :short_title
    column "Categories" do |article|
  		article.categories.map { |p| p.name }.join('<br />').html_safe
		end
    column :published_date
    if I18n.locale == :de
      column "Teaser Image" do |article| 
        image_tag(article.teaser_image.url(:thumb), :alt => "")
      end
    else
      column "Teaser Image EN" do |article| 
        image_tag(article.teaser_image_en.url(:thumb), :alt => "")
      end
    end
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
    link_to "Switch To German", edit_admin_article_de_path
  end
  action_item :only => :edit do
    link_to "Switch To English", edit_admin_article_en_path
  end

  # language switch - new page
  action_item :only => :new do
    link_to "Switch To German", new_admin_article_de_path
  end
  action_item :only => :new do
    link_to "Switch To English", new_admin_article_en_path
  end

  # language switch - index page
  action_item :only => :index do
    link_to "Switch To German", admin_articles_de_path
  end
  action_item :only => :index do
    link_to "Switch To English", admin_articles_en_path
  end

  # language switch - show page
  action_item :only => :show do
    link_to "Switch To German", admin_article_de_path
  end
  action_item :only => :show do
    link_to "Switch To English", admin_article_en_path
  end
  # action_item do
  #   link_to "Switch To German", '/de/admin/articles/' if request.path_info == '/en/admin/articles/'
  # end
  # action_item do
  #   link_to "Switch To English", '/en/admin/articles/' if request.path_info == '/de/admin/articles/'
  # end

  form do |f|
    f.inputs do
      f.input :language, :input_html => { :readonly => true, :value => I18n.locale}, :hint => "Read-only"
      # , :as => :radio, :collection => ["Deutsch", "English"]
      f.input :title, :hint => t(:translation_field)
      f.input :short_title, :hint => t(:translation_field)
      f.input :url_title, :hint => "#{t(:translation_field)}; Example: my-new-article-1"
      f.input :ctry, :label => "Country", :hint => t(:translation_field)
  		f.input :author
  		f.input :photos_by
      f.input :categories
      f.input :published_in   
      f.input :published_date, :start_year => Date.today.year - 15, :end_year => Date.today.year + 1
      # , :as => :datepicker
      f.input :article_type, :hint => t(:translation_field)
      f.input :source_file, :hint => f.object.source_file_file_name
      f.input :source_file_en, :hint => f.object.source_file_en_file_name
      f.input :copyright_cleared, :as => :radio
      f.input :teaser_image, :hint => f.template.image_tag(f.object.teaser_image.url(:thumb))
      f.input :teaser_image_en, :hint => f.template.image_tag(f.object.teaser_image_en.url(:thumb))
      f.input :address
      f.input :gmaps, :label => t(:geocoding_found)
      f.input :lon, :label => "Longitude"
      f.input :lat, :label => "Latitude"
      f.input :viewer_url, :hint => t(:translation_field)
      f.input :web_page, :hint => t(:translation_field), :label => t(:online_version)
      f.input :embed_code, :input_html => { :class => 'autogrow', :rows => 4, :cols => 20 }, :hint => t(:translation_field)
    end
    f.buttons
  end
	show do |article|
    div :class => 'panel' do
      h3 'Article Details'
      div :class => 'panel_contents' do
        div :class => 'attributes_table article' do
          table do
          	tr do
              th { 'ID' }
              td { article.id }
            end
            tr do
              th { 'Language' }
              td { article.language }
            end
            tr do
              th { 'Title' }
              td { article.title }
            end
            tr do
              th { 'Short Title' }
              td { article.short_title }
            end
            tr do
              th { 'Url Title' }
              td { article.url_title }
            end
            tr do
              th { 'Country' }
              td { article.ctry }
            end
						tr do
              th { 'Author' }
              td { article.author }
            end
            tr do
              th { 'Photos By' }
              td { article.photos_by }
            end
            tr do
              th { 'Categories' }
              td { article.categories.map { |p| p.name }.join(', ') }
            end
            tr do
              th { 'Published In' }
              td { article.published_in }
            end
            tr do
              th { 'Published Date' }
              td { article.published_date }
            end
            tr do
              th { 'Article Type' }
              td { article.article_type }
            end
            tr do
              th { 'Source File' }
              td { article.source_file }
            end
            tr do
              th { 'Source File EN' }
              td { article.source_file_en }
            end
            tr do
              th { 'Copyright Cleared' }
              td { article.copyright_cleared }
            end
            tr do
              th { 'Teaser Image' }
              td { article.teaser_image }
            end
            tr do
              th { 'Teaser Image EN' }
              td { article.teaser_image_en }
            end
            tr do
              th { 'Address' }
              td { article.address }
            end
            tr do
              th { 'Gmaps' }
              td { article.gmaps }
            end
            tr do
              th { 'Longitude' }
              td { article.lon }
            end
            tr do
              th { 'Latitude' }
              td { article.lat }
            end
            tr do
              th { 'Viewer URL' }
              td { article.viewer_url }
            end
            tr do
              th { t(:online_version) }
              td { article.web_page }
            end
            tr do
              th { 'Embed Code' }
              td { article.embed_code }
            end
            tr do
              th { 'Created At' }
              td { article.created_at }
            end
            tr do
              th { 'Updated At' }
              td { article.updated_at }
            end
          end # table
        end # attributes_table
      end # panel_contents
    end # panel
  end # show
end
