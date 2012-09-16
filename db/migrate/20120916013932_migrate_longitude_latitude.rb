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
  	RadioTrack.reset_column_information
  	RadioTrack.all.each do |radio_track|
  		if !radio_track.longitude.blank? and !radio_track.latitude.blank?
  			lon = radio_track.longitude.to_f
  			lat = radio_track.latitude.to_f
  			radio_track.update_attributes!(:lon => lon, :lat => lat)
  		end
  	end
  end

  def down
  end
end
