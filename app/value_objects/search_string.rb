class SearchString
  def initialize(model)
    @model = model
    @original_locale = I18n.locale
    @separator = ', '
  end
  def create
    search_string = get_general_keywords(@model.class.name)
    I18n.locale = :de
    search_string = build(search_string)
    I18n.locale = :en
    search_string = build(search_string)
    I18n.locale = @original_locale
    return search_string
  end

private
  def build(search_string)
    search_string += check_and_add_value(@model.title)
    search_string += check_and_add_value(@model.short_title)
    search_string += check_and_add_value(@model.url_title)
    search_string += check_and_add_value(@model.author)
    search_string += check_and_add_value(@model.ctry)
    search_string += check_and_add_value(@model.address)
    search_string += check_and_add_value(@model.category_list)
    return search_string
  end
  def check_and_add_value(value)
    if value.nil? or value.blank?
      return ''
    end  
    @separator + value 
  end
  def check_and_add_date(date)
    if date.nil? or date.blank?
      return ''
    end  
    case I18n.locale
      when :de
        date = I18n.l(date, :format => '%e. %B %Y') 
      when :en
        date = I18n.l(date, :format => '%e %B %Y')
    end
    @separator + date 
  end
  def get_general_keywords(model_name)
    case model_name
      when 'Video'
        search_string = 'TV, Video, Fernsehen'
      when 'RadioTrack'
        search_string = 'Radio, Audio, mp3'
      when 'Post'
        search_string = 'Blog, Blogeintrag, Posts'
      when 'Article'
        search_string = 'Stories, Artikel, Article'
    end
  end 
end # SearchString