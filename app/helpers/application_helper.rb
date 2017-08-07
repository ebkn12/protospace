module ApplicationHelper
  def convert_pluralize(num, word)
    if num > 1
      word.pluralize
    else
      word
    end
  end
end
