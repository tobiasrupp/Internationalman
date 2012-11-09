class PostSearchString < SearchString
  alias :super_build :build

  def build(search_string)
    search_string = super_build(search_string)
    search_string += check_and_add_date(@model.created_at)
    search_string += check_and_add_value(@model.text)
    search_string += check_and_add_value(@model.text_2)
  end  
end