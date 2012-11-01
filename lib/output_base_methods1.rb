# module OutputBaseMethods

#   def category_list
#     category_list = ''
#     self.categories.each do |category|
#       if category_list == ''
#         category_list = category.name
#       else
#         category_list = category_list + ', ' + category.name
#       end
#     end
#     return category_list
#   end

#   def map_icon(image_path)
#   {
#    "picture" => "#{image_path}",
#    "width" => 32,
#    "height" => 37,
#    # "marker_anchor" => [ 5, 10],
#    "shadow_picture" => "http://maps.google.com/mapfiles/shadow50.png" ,
#    "shadow_width" => "37",
#    "shadow_height" => "34",
#    "shadow_anchor" => [10, 32],
#   }
#   end

#   def search_string
#   	# builds a search string with field values including German and English translations
#     original_locale = I18n.locale
#     separator = ', '
#     I18n.locale = :de
#     i = 0
#     case self.class.name
#    	 	when 'Video'
#     		search_string = 'TV, Video, Fernsehen'
#       when 'RadioTrack'
#         search_string = 'Radio, Audio, mp3'
#       when 'Post'
#         search_string = 'Blog, Blogeintrag, Posts'
#       when 'Article'
#         search_string = 'Stories, Artikel, Article'
#     end
#  		2.times do
# 			# loop 2 times, first in German then in English
#  			i += 1
#  			if i == 2
#  				I18n.locale = :en
#  			end
# 	    search_string = search_string + separator + self.title unless self.title.nil? or self.title.blank?
# 	    search_string = search_string + separator + self.short_title unless self.short_title.nil? or self.short_title.blank?
# 	    search_string = search_string + separator + self.url_title unless self.url_title.nil? or self.url_title.blank?
# 	    search_string = search_string + separator + self.author unless self.author.nil? or self.author.blank?
#       search_string = search_string + separator + self.ctry unless self.ctry.nil? or self.ctry.blank?
#       search_string = search_string + separator + self.address unless self.address.nil? or self.address.blank?
#       search_string = search_string + separator + self.category_list unless self.category_list.nil? or self.category_list.blank?
#       if self.class.name == 'Video' or self.class.name == 'RadioTrack'
#   	    if i == 1 # German
#   	    	search_string = search_string + separator + I18n.l(self.broadcast_date, :format => '%e. %B %Y') unless self.broadcast_date.nil? or self.broadcast_date.blank? 
#   	  	elsif i == 2 # English
#   	    	search_string = search_string + separator + I18n.l(self.broadcast_date, :format => '%e %B %Y') unless self.broadcast_date.nil?  or self.broadcast_date.blank?
#   	    end
#   	    search_string = search_string + separator + self.broadcaster unless self.broadcaster.nil? or self.broadcaster.blank?
#       elsif self.class.name == 'Post'
#         if i == 1 # German
#           search_string = search_string + separator + I18n.l(self.created_at, :format => '%e. %B %Y') unless self.created_at.nil? or self.created_at.blank? 
#         elsif i == 2 # English
#           search_string = search_string + separator + I18n.l(self.created_at, :format => '%e %B %Y') unless self.created_at.nil?  or self.created_at.blank?
#         end
#         search_string = search_string + separator + self.text unless self.text.nil? or self.text.blank?
#         search_string = search_string + separator + self.text_2 unless self.text_2.nil? or self.text_2.blank?
#       elsif self.class.name == 'Article'
#         if i == 1 # German
#           search_string = search_string + separator + I18n.l(self.published_date, :format => '%e. %B %Y') unless self.published_date.nil? or self.published_date.blank? 
#         elsif i == 2 # English
#           search_string = search_string + separator + I18n.l(self.published_date, :format => '%e %B %Y') unless self.published_date.nil?  or self.published_date.blank?
#         end
#         search_string = search_string + separator + self.published_in unless self.published_in.nil? or self.published_in.blank?
#         search_string = search_string + separator + self.photos_by unless self.photos_by.nil? or self.photos_by.blank?
#         search_string = search_string + separator + self.article_type unless self.article_type.nil? or self.article_type.blank?
#       end 
#   	end
#   	I18n.locale = original_locale
# 		return search_string
#   end  
# end
