module PostsHelper

	def get_post_summary(post)
	# 	if post.nil?
	# 		return
	# 	end
	# 	summary = ""
	# 	if !post.title.blank?
	# 		summary = <h3> post.title</h3>
	# 	end	
	# 	line_string = "<p>"
	# 	if !post.updated_at.blank?
	# 		if !line_string.blank? 
	# 			line_string = line_string + ", "
	# 		end
	# 		line_string = line_string + "#{l post.updated_at, :format => :long}"
	# 	end
	# 	if !post.ctry.blank?
	# 		if !line_string.blank? 
	# 			line_string = line_string + ", "
	# 		end
	# 		line_string = line_string + t(:country) + ": #{post.ctry}"
	# 	end
	# 	if !post.author.blank?
	# 		if !line_string.blank? 
	# 			line_string = line_string + ", "
	# 		end
	# 		line_string = line_string + t(:text) + ": #{post.author}"
	# 	end
	# 	if !line_string.blank? 
	# 			raw line_string<br>
	# 			@fb_description = @fb_description + raw(line_string)
	# 	end 

	# 	if !post.categories.nil?
	# 		category_string = ""
	# 			t(:categories): 
	# 			post.categories.each do |category| 
	# 			if category_string.blank?
	# 				category_string = category.name
	# 			else
	# 				category_string = category_string + ", " + category.name
	# 			end
	# 		end
	# 		category_string<br>
	# 		@fb_description = @fb_description + ", " + t(:categories) + ': ' + category_string
	# 	end
	# </p>
	# render 'shared/map_button'
	# <div class="post_body">
	# 	if post.image_1?
	# 		if post.image_1_options?
	# 			split_arr = post.image_1_options.split(' - ')
	# 			display_option = split_arr[0]	
	# 			if display_option != "Don't display"
	# 				image_size = split_arr[1].parameterize
	# 				case display_option
	# 					when "Display in Section 1 left"
	# 						<img src="post.image_1.url(image_size)" alt="" class="thumbnail pull-left" style="margin-right: 0.8em; margin-bottom: 0.3em">
	# 					when "Display in Section 1 right"
	# 						<img src="post.image_1.url(image_size)" alt="" class="thumbnail pull-right" style="margin-left: 0.8em; margin-bottom: 0.3em">
	# 				end		
	# 			end	
	# 		end				
	# 	end
	# 	if post.image_2?
	# 		if post.image_2_options?
	# 			split_arr = post.image_2_options.split(' - ')
	# 			display_option = split_arr[0]	
	# 			if display_option != "Don't display"
	# 				image_size = split_arr[1].parameterize
	# 				case display_option
	# 					when "Display in Section 1 left"
	# 						<img src="post.image_2.url(image_size)" alt="" class="thumbnail pull-left" style="margin-right: 0.8em; margin-bottom: 0.3em">
	# 					when "Display in Section 1 right"
	# 						<img src="post.image_2.url(image_size)" alt="" class="thumbnail pull-right" style="margin-left: 0.8em; margin-bottom: 0.3em">
	# 				end		
	# 			end	
	# 		end				
	# 	end
	# 	if !post.text.blank?
	# 		<p>raw post.text</p>
	# 		@fb_description = @fb_description + ", " + raw(post.text)
	# 	end	
	# 	if post.image_1?
	# 		if post.image_1_options?
	# 			split_arr = post.image_1_options.split(' - ')
	# 			display_option = split_arr[0]	
	# 			if display_option != "Don't display"
	# 				image_size = split_arr[1].parameterize
	# 				case display_option
	# 					when "Display in Section 2 left"
	# 						<img src="post.image_1.url(image_size)" alt="" class="thumbnail pull-left" style="margin-right: 0.8em; margin-bottom: 0.3em">
	# 					when "Display in Section 2 right"
	# 						<img src="post.image_1.url(image_size)" alt="" class="thumbnail pull-right" style="margin-left: 0.8em; margin-bottom: 0.3em">
	# 				end		
	# 			end		
	# 		end	
	# 	end
	# 	if post.image_2?
	# 		if post.image_2_options?
	# 			split_arr = post.image_2_options.split(' - ')
	# 			display_option = split_arr[0]	
	# 			if display_option != "Don't display"
	# 				image_size = split_arr[1].parameterize
	# 				case display_option
	# 					when "Display in Section 2 left"
	# 						<img src="post.image_2.url(image_size)" alt="" class="thumbnail pull-left" style="margin-right: 0.8em; margin-bottom: 0.3em">
	# 					when "Display in Section 2 right"
	# 						<img src="post.image_2.url(image_size)" alt="" class="thumbnail pull-right" style="margin-left: 0.8em; margin-bottom: 0.3em">
	# 				end	
	# 			end			
	# 		end		
	# 	end
	# 	if !post.text_2.blank?
	# 		<p>raw post.text_2</p>
	# 		@fb_description = @fb_description + raw(post.text_2)
	# 	end
	# </div>
	end
end
