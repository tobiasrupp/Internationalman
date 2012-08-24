ActiveAdmin.register Post do
  index do
    column :title
    column "Categories" do |post|
  		post.categories.map { |p| p.name }.join('<br />').html_safe
		end
		# column :country
    # column :long
    # column :lat	
    column :updated_at
    column :url_title
    column :publication_state
		default_actions
  end

  form do |f|
    f.inputs do
      f.input :title, :required => true
      f.input :short_title, :required => true
      f.input :url_title, :required => true, :hint => 'Beispiel: mein-neuer-blog-eintrag'
      f.input :text
      f.input :publication_state, :as => :radio, :collection => ["Unpublished", "Published"], :required => true
      f.input :language
      f.input :author
      f.input :categories
  		f.input :country, :priority_countries => []
      f.input :longitude
      f.input :latitude
      # f.input :allow_comments, :label => "Allow commenting on this post"
    end
    f.buttons
  end
	show do |post|
    div :class => 'panel' do
      h3 'Post Details'
      div :class => 'panel_contents' do
        div :class => 'attributes_table post' do
          table do
          	tr do
              th { 'ID' }
              td { post.id }
            end
            tr do
              th { 'Title' }
              td { post.title }
            end
            tr do
              th { 'Short Title' }
              td { post.short_title }
            end
            tr do
              th { 'Url Title' }
              td { post.url_title }
            end
            tr do
              th { 'Publication State' }
              td { post.publication_state }
            end
            tr do
              th { 'Text' }
              td { post.text }
            end
            tr do
              th { 'Language' }
              td { post.language }
            end
            tr do
              th { 'Categories' }
              td { post.categories.map { |p| p.name }.join(', ') }
            end
            tr do
              th { 'Country' }
              td { post.country }
            end
						tr do
              th { 'Author' }
              td { post.author }
            end
            tr do
              th { 'Longitude' }
              td { post.longitude }
            end
            tr do
              th { 'Latitude' }
              td { post.latitude }
            end
            tr do
              th { 'Created At' }
              td { post.created_at }
            end
            tr do
              th { 'Updated At' }
              td { post.updated_at }
            end
          end # table
        end # attributes_table
      end # panel_contents
    end # panel
  end # show
end
