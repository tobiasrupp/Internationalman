ActiveAdmin.register StatusMessage do
   index do
    column :text
    column :updated_at
    column :language
		default_actions
  end

  # language switch - edit page
  action_item :only => :edit do
    link_to "Switch To German", edit_admin_status_message_de_path
  end
  action_item :only => :edit do
    link_to "Switch To English", edit_admin_status_message_en_path
  end

  # language switch - new page
  action_item :only => :new do
    link_to "Switch To German", new_admin_status_message_de_path
  end
  action_item :only => :new do
    link_to "Switch To English", new_admin_status_message_en_path
  end

# language switch - index page
  action_item :only => :index do
    link_to "Switch To German", admin_status_messages_de_path
  end
  action_item :only => :index do
    link_to "Switch To English", admin_status_messages_en_path
  end

  # language switch - show page
  action_item :only => :show do
    link_to "Switch To German", admin_status_message_de_path
  end
  action_item :only => :show do
    link_to "Switch To English", admin_status_message_en_path
  end

  form do |f|
    f.inputs do
    	f.input :language, :input_html => { :readonly => true, :value => I18n.locale}, :hint => "Read-only"
      f.input :text, :required => true, :input_html => { :size => 255 }
    end
    f.buttons
  end
	show do |status_message|
    div :class => 'panel' do
      h3 'Status Message Details'
      div :class => 'panel_contents' do
        div :class => 'attributes_table status_message' do
          table do
          	tr do
              th { 'ID' }
              td { status_message.id }
            end
            tr do
              th { 'Language' }
              td { status_message.language }
            end
            tr do
              th { 'Text' }
              td { status_message.text }
            end
            tr do
              th { 'Created At' }
              td { status_message.created_at }
            end
            tr do
              th { 'Updated At' }
              td { status_message.updated_at }
            end
          end # table
        end # attributes_table
      end # panel_contents
    end # panel
  end # show
end
