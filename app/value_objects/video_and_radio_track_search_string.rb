class VideoAndRadioTrackSearchString < SearchString
  alias :super_build :build

  def build(search_string)
    search_string = super_build(search_string)
    search_string += check_and_add_date(@model.broadcast_date)
    search_string += check_and_add_value(@model.broadcaster)
  end  
end