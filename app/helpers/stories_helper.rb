module StoriesHelper


	def get_story_summary(article)
		if article.nil?
			return
		end
		summary = render_to_string(:partial => 'mstory_details', :layout => false, :locals => {:selected_article => article})

		# summary = ""
		# if !article.title.blank?
		# 	summary = "<h3>#{article.title}</h3>"
		# end
		# line_string = "<p>"
		# if !article.published_in.blank?
		# 	line_string = line_string + t(:published_in) + " <em>#{ article.published_in }</em>"
		# end
		# if !article.article_type.blank?
		# 	if !line_string.blank?
		# 		line_string = line_string + " "
		# 	end
		# 	line_string = line_string + "(#{article.article_type})"
		# end
		# if !article.published_date.blank?
		# 	if !line_string.blank?
		# 		line_string = line_string + ", "
		# 	end
		# 	line_string = line_string + "#{l article.published_date, :format => :long}"
		# end
		# if !line_string.blank? 
		# 	summary = summary + raw(line_string)
		# end

		# line_string = ""
		# if !article.ctry.blank?
		# 	if !line_string.blank? 
		# 		line_string = line_string + ", "
		# 	end
		# 	line_string = line_string + t(:country) + ": #{article.ctry}"
		# end
		# if !article.author.blank?
		# 	if !line_string.blank? 
		# 		line_string = line_string + ", "
		# 	end
		# 	line_string = line_string + t(:text) + ": #{article.author}"
		# end
		# if !article.photos_by.blank?
		# 	if !line_string.blank?
		# 		line_string = line_string + ", "
		# 	end
		# 	line_string = line_string + t(:photos) + ": #{article.photos_by}"
		# end
		# if !line_string.blank?
		# 		summary = summary + ", " + raw(line_string)
		# end

		# if !article.categories.nil?
		# 	category_string = ""
		# 				article.categories.each do |category|
		# 					if category_string.blank?
		# 						category_string = category.name
		# 					else
		# 						category_string = category_string + ", " + category.name
		# 					end
		# 				end
		# 				summary = summary + ", " + t(:categories) + ': ' + category_string
		# end
		# summary = summary + "</p>"
		# return summary
	end
end
