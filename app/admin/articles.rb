ActiveAdmin.register Article do 
  scope :corporate_articles
	index do
		column :id
    column :title
    column :short_title
    # column :url_title
    # column :ctry
    # column :author
    # column :photos_by
    column "Categories" do |article|
  		article.categories.map { |p| p.name }.join('<br />').html_safe
		end
    column :published_date
    # column :published_in
    column "Teaser Image" do |article| 
      image_tag(article.teaser_image.url(:thumb), :alt => "")
    end
		default_actions
  end
  # filter :title
  # sidebar :switch_language, :priority => 1 do
  #   ul do
  #     li strong { link_to "Deutsch", admin_articles_de_path }
  #     li strong { link_to "English", admin_articles_en_path }  
  #   end
  # end

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
      f.input :title
      # , :hint => "#{request.path_info}"
      f.input :short_title
      f.input :url_title, :hint => "Example: my-new-article-1"
      f.input :ctry, :label => "Country"
  		f.input :author
  		f.input :photos_by
      f.input :categories
      f.input :published_in   
      f.input :published_date, :start_year => Date.today.year - 15, :end_year => Date.today.year + 1
      # , :as => :datepicker
      f.input :article_type
      f.input :teaser_image, :hint => f.template.image_tag(f.object.teaser_image.url(:thumb))
      f.input :longitude
      f.input :latitude
      f.input :viewer_url
      f.input :web_page
      f.input :embed_code, :input_html => { :class => 'autogrow', :rows => 4, :cols => 20 }
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
              th { 'Teaser Image' }
              td { article.teaser_image }
            end
            tr do
              th { 'Longitude' }
              td { article.longitude }
            end
            tr do
              th { 'Latitude' }
              td { article.latitude }
            end
            tr do
              th { 'Viewer URL' }
              td { article.viewer_url }
            end
            tr do
              th { 'Web Page' }
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
