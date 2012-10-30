Given /^these radio track records exist$/ do |table|
  table.hashes.each do |attributes|
  	attributes["categories"] = Category.where(:name => attributes["categories"].split(', ')).all
    radio_track = RadioTrack.create!(attributes)
  end
end

Given /^these video records exist$/ do |table|
  table.hashes.each do |attributes|
  	attributes["categories"] = Category.where(:name => attributes["categories"].split(', ')).all
    video = Video.create!(attributes)
  end
end

Given /^these post records exist$/ do |table|
  table.hashes.each do |attributes|
  	attributes["categories"] = Category.where(:name => attributes["categories"].split(', ')).all
    post = Post.create!(attributes)
  end
end