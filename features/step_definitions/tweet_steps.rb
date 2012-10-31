Given /^these status message records exist$/ do |table|
  table.hashes.each do |attributes|
    status_message = StatusMessage.create!(attributes)
  end
end
