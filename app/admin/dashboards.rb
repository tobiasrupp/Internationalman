ActiveAdmin::Dashboards.build do

  # Define your dashboard sections here. Each block will be
  # rendered on the dashboard in the context of the view. So just
  # return the content which you would like to display.
  
  # == Simple Dashboard Section
  # Here is an example of a simple dashboard section
  #
  #   section "Recent Posts" do
  #     ul do
  #       Post.recent(5).collect do |post|
  #         li link_to(post.title, admin_post_path(post))
  #       end
  #     end
  #   end
  
  # == Render Partial Section
  # The block is rendered within the context of the view, so you can
  # easily render a partial rather than build content in ruby.
  #
  #   section "Recent Posts" do
  #     div do
  #       render 'recent_posts' # => this will render /app/views/admin/dashboard/_recent_posts.html.erb
  #     end
  #   end
  
  # == Section Ordering
  # The dashboard sections are ordered by a given priority from top left to
  # bottom right. The default priority is 10. By giving a section numerically lower
  # priority it will be sorted higher. For example:
  #
  #   section "Recent Posts", :priority => 10
  #   section "Recent User", :priority => 1
  #
  # Will render the "Recent Users" then the "Recent Posts" sections on the dashboard.
  
  # == Conditionally Display
  # Provide a method name or Proc object to conditionally render a section at run time.
  #
  # section "Membership Summary", :if => :memberships_enabled?
  # section "Membership Summary", :if => Proc.new { current_admin_user.account.memberships.any? }
  
  section "Recent Articles", :priority => 1 do
    table_for Article.order("updated_at desc").limit(3) do
      column :title do |article|
        link_to article.title, [:admin, article]
      end
      column :updated_at
    end
    strong { link_to "View All Articles", admin_articles_path }
  end
  section "Recent Radio Tracks", :priority => 3 do
    table_for RadioTrack.order("updated_at desc").limit(3) do
      column :title do |radio_track|
        link_to radio_track.title, [:admin, radio_track]
      end
      column :updated_at
    end
    strong { link_to "View All Radio Tracks", admin_radio_tracks_path }
  end
  section "Recent Videos", :priority => 4 do
    table_for Video.order("updated_at desc").limit(3) do
      column :title do |video|
        link_to video.title, [:admin, video]
      end
      column :updated_at
    end
    strong { link_to "View All Videos", admin_videos_path }
  end
  section "Recent Blog Posts", :priority => 2 do
    table_for Post.order("updated_at desc").limit(3) do
      column :title do |post|
        link_to post.title, [:admin, post]
      end
      column :updated_at
    end
    strong { link_to "View All Posts", admin_posts_path }
  end
end
