module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /the home\s?page/
      '/'

    # the following are examples using path_to_pickle

    when /^#{capture_model}(?:'s)? page$/                           # eg. the forum's page
      path_to_pickle $1

    when /^#{capture_model}(?:'s)? #{capture_model}(?:'s)? page$/   # eg. the forum's post's page
      path_to_pickle $1, $2

    when /^#{capture_model}(?:'s)? #{capture_model}'s (.+?) page$/  # eg. the forum's post's comments page
      path_to_pickle $1, $2, :extra => $3                           #  or the forum's post's edit page

    when /^#{capture_model}(?:'s)? (.+?) page$/                     # eg. the forum's posts page
      path_to_pickle $1, :extra => $2                               #  or the forum's edit page

    when /Contact page/
      contact_en_path
    
    when /About page/
      about_en_path

    when /Homepage/
      root_path

    when /Corporate page/
      corporate_en_path   

    when /Stories page/
      stories_en_path

    when /TV page/
      tv_en_path

    when /Radio page/
      radio_en_path

    when /Radio Track page/
      '/en/admin/radio_tracks'

    when /Videos page/
      '/en/admin/videos'

    when /Blog page/
      blog_en_path         
      
    when /Posts page/
      '/en/admin/posts'      
      
    when /Status Messages page/
      '/en/admin/status_messages' 

    when /Dashboard/
      '/en/admin'

    when /Pages page/
      '/en/admin/pages'  

    when /Categories page/
      '/en/admin/categories' 

    when /Articles page/
      '/en/admin/articles' 

    when /Map page/
      map_en_path

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /the (.*) page/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue Object => e
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)