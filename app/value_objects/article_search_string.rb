class ArticleSearchString < SearchString
  alias :super_build :build

  def build(search_string)
    search_string = super_build(search_string)
    search_string += check_and_add_date(@model.published_date)
    search_string += check_and_add_value(@model.published_in)
    search_string += check_and_add_value(@model.photos_by)
    search_string += check_and_add_value(@model.article_type)    
  end  
end