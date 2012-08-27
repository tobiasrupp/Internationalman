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
    column "Image 1" do |post| 
      image_tag(post.image_1.url(:thumb), :alt => "")
    end
    column "Image 2" do |post| 
      image_tag(post.image_2.url(:thumb), :alt => "")
    end
		default_actions
  end

  form do |f|
    f.inputs do
      f.input :title, :required => true, :input_html => { :size => 255 }
      f.input :short_title, :required => true, :input_html => { :size => 80 }
      f.input :url_title, :required => true, :hint => 'Beispiel: mein-neuer-blog-eintrag', :input_html => { :size => 80 }
      f.input :publication_state, :as => :radio, :collection => ["Unpublished", "Published"], :required => true
      f.input :language, :input_html => { :disabled => true }
      f.input :author
      f.input :categories
      f.input :text, :label => "Text section 1", :input_html => { :class => 'autogrow', :rows => 10, :cols => 20 }
      f.input :image_1, :hint => f.template.image_tag(f.object.image_1.url(:thumb))
      f.input :image_1_options, :as => :select, :collection => ["Don't display", "Display in Section 1 left - Small", "Display in Section 1 left - Medium", "Display in Section 1 right - Small", "Display in Section 1 right - Medium", "Display in Section 2 left - Small", "Display in Section 2 left - Medium", "Display in Section 2 right - Small", "Display in Section 2 right - Medium"], :required => false
      f.input :text_2, :label => "Text section 2", :input_html => { :class => 'autogrow', :rows => 10, :cols => 20 }
      f.input :image_2, :hint => f.template.image_tag(f.object.image_2.url(:thumb))
      f.input :image_2_options, :as => :select, :collection => ["Don't display", "Display in Section 1 left - Small", "Display in Section 1 left - Medium", "Display in Section 1 right - Small", "Display in Section 1 right - Medium", "Display in Section 2 left - Small", "Display in Section 2 left - Medium", "Display in Section 2 right - Small", "Display in Section 2 right - Medium"], :required => false
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
              th { 'Text Section 1' }
              td { post.text }
            end
            tr do
              th { 'Image 1' }
              td { post.image_1 }
            end
            tr do
              th { 'Image 1 Options' }
              td { post.image_1_options }
            end
            tr do
              th { 'Text Section 2' }
              td { post.text_2 }
            end
            tr do
              th { 'Image 2' }
              td { post.image_2 }
            end
            tr do
              th { 'Image 2 Options' }
              td { post.image_2_options }
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
