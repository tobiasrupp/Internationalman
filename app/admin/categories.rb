ActiveAdmin.register Category do
  index do
		column :id
    column :name
    column :url_name
    column :display_section
   	column :display_sequence
    column "Lang.", :language
		default_actions
  end

  filter :name, :as => :string
  filter :url_name, :as => :string

  # language switch - edit page
  action_item :only => :edit do
    link_to "Switch To German", edit_admin_category_de_path
  end
  action_item :only => :edit do
    link_to "Switch To English", edit_admin_category_en_path
  end

  # language switch - new page
  action_item :only => :new do
    link_to "Switch To German", new_admin_category_de_path
  end
  action_item :only => :new do
    link_to "Switch To English", new_admin_category_en_path
  end

# language switch - index page
  action_item :only => :index do
    link_to "Switch To German", admin_categories_de_path
  end
  action_item :only => :index do
    link_to "Switch To English", admin_categories_en_path
  end

  # language switch - show page
  action_item :only => :show do
    link_to "Switch To German", admin_category_de_path
  end
  action_item :only => :show do
    link_to "Switch To English", admin_category_en_path
  end

  form do |f|
    f.inputs do
      f.input :language, :input_html => { :readonly => true, :value => I18n.locale}, :hint => "Read-only"
      f.input :name, :hint => t(:translation_field)
      f.input :url_name, :hint => "#{t(:translation_field)}; Example: my-new-category"
      f.input :display_section
    	f.input :display_sequence
    end
    f.buttons
  end
	show do |category|
    div :class => 'panel' do
      h3 'Category Details'
      div :class => 'panel_contents' do
        div :class => 'attributes_table category' do
          table do
          	tr do
              th { 'ID' }
              td { category.id }
            end
            tr do
              th { 'Language' }
              td { category.language }
            end
            tr do
              th { 'Name' }
              td { category.name }
            end
            tr do
              th { 'Url Name' }
              td { category.url_name }
            end
            tr do
              th { 'Display Section' }
              td { category.display_section }
            end
						tr do
              th { 'Display Sequence' }
              td { category.display_sequence }
            end
            tr do
              th { 'Created At' }
              td { category.created_at }
            end
            tr do
              th { 'Updated At' }
              td { category.updated_at }
            end
          end # table
        end # attributes_table
      end # panel_contents
    end # panel
  end # show
end
