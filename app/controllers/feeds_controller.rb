class FeedsController < ApplicationController
  
  def feed
  	@title = t(:alexander_buehler) + " - Journalist"
    @articles = Article.find(:all,
                  :include => :categories,
                  :order => "published_date DESC")
    @updated = @articles.first.published_date unless @articles.empty?
    @radio_tracks = RadioTrack.find(:all,
                  :include => :categories,
                  :order => "broadcast_date DESC")
    updated = @radio_tracks.first.broadcast_date unless @radio_tracks.empty?
    if updated > @updated
      @updated = updated
    end
    @videos = Video.find(:all,
                  :include => :categories,
                  :order => "broadcast_date DESC")
    updated = @videos.first.broadcast_date unless @videos.empty?
    if updated > @updated
      @updated = updated
    end
    @posts = Post.find(:all,
                :include => :categories,
                :conditions => "publication_state = 'Published'",
                :order => "created_at DESC")
    updated = @posts.first.created_at unless @posts.empty?
    if updated > @updated
      @updated = updated
    end
    respond_to do |format|
      format.atom
    end
  end
end
