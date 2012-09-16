ActiveAdmin.register Page do
  index do
		column :id
    column :title
    column :body
    column :page_type
    column "Lang.", :language
		default_actions
  end

  filter :body

  # language switch - edit page
  action_item :only => :edit do
    link_to "Switch To German", edit_admin_page_de_path
  end
  action_item :only => :edit do
    link_to "Switch To English", edit_admin_page_en_path
  end

  # language switch - new page
  action_item :only => :new do
    link_to "Switch To German", new_admin_page_de_path
  end
  action_item :only => :new do
    link_to "Switch To English", new_admin_page_en_path
  end

# language switch - index page
  action_item :only => :index do
    link_to "Switch To German", admin_pages_de_path
  end
  action_item :only => :index do
    link_to "Switch To English", admin_pages_en_path
  end

  # language switch - show page
  action_item :only => :show do
    link_to "Switch To German", admin_page_de_path
  end
  action_item :only => :show do
    link_to "Switch To English", admin_page_en_path
  end

  form do |f|
    f.inputs do
      f.input :language, :input_html => { :readonly => true, :value => I18n.locale}, :hint => "Read-only"
      f.input :page_type, :as => :radio, :collection => ["CONTACT", "ABOUT"]
      f.input :title, :hint => t(:translation_field)
      f.input :body, :label => "Text", :hint => "#{t(:translation_field)}; Use HTML formatting e.g. <p>...</p>", :input_html => { :class => 'autogrow', :rows => 10, :cols => 20 }
    end
    f.buttons
  end
	show do |page|
    div :class => 'panel' do
      h3 'Page Details'
      div :class => 'panel_contents' do
        div :class => 'attributes_table page' do
          table do
          	tr do
              th { 'ID' }
              td { page.id }
            end
            tr do
              th { 'Language' }
              td { page.language }
            end
            tr do
              th { 'Page Type' }
              td { page.page_type }
            end
            tr do
              th { 'Title' }
              td { page.title }
            end
            tr do
              th { 'Text' }
              td { page.body }
            end
            tr do
              th { 'Created At' }
              td { page.created_at }
            end
            tr do
              th { 'Updated At' }
              td { page.updated_at }
            end
          end # table
        end # attributes_table
      end # panel_contents
    end # panel
  end # show
end
