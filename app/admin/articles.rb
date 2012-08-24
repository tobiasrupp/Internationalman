ActiveAdmin.register Article do 
	index do
		column :id
    column :title
    # column :country
    column :author
    # column :photos_by
    column "Categories" do |article|
  		article.categories.map { |p| p.name }.join('<br />').html_safe
		end
    # column :long
    # column :lat	
    # column :article_type
    column :published_date
    # column :published_in
    # column :filename
    column :url_title
    column "Teaser Image" do |article| 
      image_tag(article.teaser_image.url(:thumb), :alt => "")
    end
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
  		f.input :photos_by
      f.input :categories
      f.input :longitude
      f.input :latitude
      
      f.input :published_date, :start_year => Date.today.year - 15, :end_year => Date.today.year + 1
      f.input :published_in
      f.input :teaser_image, :hint => f.template.image_tag(f.object.teaser_image.url(:thumb))
      f.input :article_type
      f.input :viewer_url
      f.input :filename
      f.input :embed_code
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
              th { 'Language' }
              td { article.language }
            end
            tr do
              th { 'Country' }
              td { article.country }
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
              th { 'Longitude' }
              td { article.longitude }
            end
            tr do
              th { 'Latitude' }
              td { article.latitude }
            end
            tr do
              th { 'Article Type' }
              td { article.article_type }
            end
            tr do
              th { 'Published Date' }
              td { article.published_date }
            end
            tr do
              th { 'Published In' }
              td { article.published_in }
            end
            tr do
              th { 'Filename' }
              td { article.filename }
            end
            tr do
              th { 'Viewer URL' }
              td { article.viewer_url }
            end
            tr do
              th { 'Embed Code' }
              td { article.embed_code }
            end
            tr do
              th { 'Teaser Image' }
              td { article.teaser_image }
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
