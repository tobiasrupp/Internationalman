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

  def title
    return '' if @object.title.blank?
    s = ('<h3>' + @object.title + '</h3>').html_safe
  end


  def author(line_string)
    return '' if @object.author.blank?
    line_string = add_separator(line_string)
    line_string += t(:text) + ": #{@object.author}"
  end

  def country(line_string = '')
    return '' if @object.ctry.blank?
    line_string = add_separator(line_string)
    line_string += t(:country) + ": #{@object.ctry}"
  end

  def category_list
    return '' if @object.categories.count == 0
    category_list = ''
    @object.categories.each do |category|
      category_list = add_separator(category_list)
      category_list += category.name
    end
    return t(:categories) + ': ' + category_list
  end

  def web_page
    return '' if @object.web_page.blank?
    s = ('<div class="button">' + link_to(t(:online_version), @object.web_page, :target => '_blank', :class => "btn btn-small") + '</div>').html_safe
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

