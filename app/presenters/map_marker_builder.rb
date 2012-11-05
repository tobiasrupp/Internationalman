# class MapMarkerBuilder

# 	def initialize(template)
# 		@template = template
# 	end

#   def build(object, marker)
#   	@object = object
#   	@marker = marker
#     case @object.class.name
# 			when 'RadioTrack'
# 				set_base_values('(Radio)')
# 				@marker.infowindow(radio_track_summary(@object))
# 			when 'Post'
# 				set_base_values('(Blog)')
# 				@marker.infowindow(post_summary(@object))
# 			when 'Video'
# 				set_base_values('(TV)')
# 				@marker.infowindow(video_summary(@object))
# 			when 'Article'
# 				is_corporate = corporate_article?(@object)
# 				if is_corporate == true
# 					@marker = build_corporate_article(@object)
# 				else
# 					set_base_values('(Stories)')
# 					@marker.infowindow(article_summary(@object))
# 				end
# 		end
#     return @marker
#   end

# private     
 
# 	def set_base_values(suffix)
# 		@marker.title(@object.title + ' ' + suffix)
#     @marker.json({ :id => @object.id })
# 	end

# 	def article_summary(article)
#     @template.render :partial => 'stories/story_details', :locals => {:@selected_article => article, :@format_for_map => true}
#   end
#   def radio_track_summary(track)
#     @template.render :partial => 'radio_tracks/radio_track_details', :locals => {:@selected_track => track, :@format_for_map => true}
#   end
#   def video_summary(video)
#     @template.render :partial => 'videos/video_details', :locals => {:@selected_video => video, :@format_for_map => true}
#   end
#   def post_summary(post)
#     @template.render :partial => 'posts/post_details', :locals => {:@selected_post => post, :@format_for_map => true}
#   end
#   def corporate_article?(article)
#     is_corporate = false
#     article.categories.each do |category|
#       if category.name == 'Corporate'
#         is_corporate = true
#         break
#       end
#     end
#     return is_corporate
#   end
#   def build_corporate_article(article)
#     @marker.title(article.title + ' (Corporate)')
#     @marker.json({ :id => article.id, "picture" => "/assets/clothers_male_b_w.png",
#        "width" => 32,
#        "height" => 37,
#        "shadow_picture" => "http://maps.google.com/mapfiles/shadow50.png" ,
#        "shadow_width" => "37",
#        "shadow_height" => "34",
#        "shadow_anchor" => [10, 34]
#       })
#     return @marker
#   end  
# end  
