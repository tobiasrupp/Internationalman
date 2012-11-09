class BasePresenter
  def initialize(object, template)
    @object = object
    @template = template
  end
  
  def self.presents(name)
    define_method(name) do
      @object
    end
  end
  
  def h
    @template
  end

  def author(line_string)
    return '' if story.author.blank?
    line_string = add_separator(line_string)
    line_string += t(:text) + ": #{story.author}"
  end

  def country(line_string = '')
    return '' if story.ctry.blank?
    line_string = add_separator(line_string)
    line_string += t(:country) + ": #{story.ctry}"
  end

  def category_list
    return '' if story.categories.count == 0
    category_list = ''
    story.categories.each do |category|
      category_list = add_separator(category_list)
      category_list += category.name
    end
    return t(:categories) + ': ' + category_list
  end

  def add_separator(string, separator = ', ')
    if string.present?
      return string += separator
    else
      return ''
    end
  end 

private  

	def method_missing(*args, &block)
 	 @template.send(*args, &block)
	end
end

