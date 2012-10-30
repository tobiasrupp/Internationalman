Then /^the feed data sent from the webserver should contain keywords "(.*?)"$/ do |keywords|
  response = RestClient.get('localhost:3001/de/feed') 
  response.code.should == 200
  keys = keywords.split(', ')
  keys.each do |key|
  	response.body.should include(key)
  end
end
