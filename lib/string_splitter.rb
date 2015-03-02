#See http://blogs.agilefaqs.com/2009/07/08/refactoring-teaser-part-1/

class StringSplitter
  def split input, number
    strings = input.split
    phrases = (1..strings.size).flat_map {|n| phrases strings, n }
    format_output phrases, number
  end
 
  private
 
  def phrases strings, length
    strings.each_cons(length).map {|group| group.join " " }
  end

  def format_output phrases, number
    phrases.take(number).map {|phrase| "'#{phrase}'" }.join ", "
  end
end
