class MigrateLongitudeLatitude < ActiveRecord::Migration
  
  class RadioTrack < ActiveRecord::Base
  end
  class Video < ActiveRecord::Base
  end
  class Post < ActiveRecord::Base
  end
  class Article < ActiveRecord::Base
  end

  def up
  	# say "Copying any existing data to lat/lon fields."
  	# RadioTrack.reset_column_information
  	# count = 0
  	# RadioTrack.all.each do |radio_track|
  	# 	if !radio_track.longitude.blank? and !radio_track.latitude.blank?
  	# 		say "Row: #{radio_track.title}"
  	# 		lon = radio_track.longitude.to_f
  	# 		lat = radio_track.latitude.to_f
  	# 		if radio_track.update_attributes!(:lon => lon, :lat => lat, :gmaps => true, :address => 'Bensheim, Deutschland')
  	# 			count = count + 1
  	# 		end
  	# 	end
  	# end
  	# say "Rows migrated: #{count.to_s}"

  	# Video.reset_column_information
  	# count = 0
  	# Video.all.each do |video|
  	# 	if !video.longitude.blank? and !video.latitude.blank?
  	# 		say "Row: #{video.title}"
  	# 		lon = video.longitude.to_f
  	# 		lat = video.latitude.to_f
  	# 		if video.update_attributes!(:lon => lon, :lat => lat, :gmaps => true, :address => 'Bensheim, Deutschland')
  	# 			count = count + 1
  	# 		end
  	# 	end
  	# end
  	# say "Rows migrated: #{count.to_s}"
  end

  def down
  end
end
