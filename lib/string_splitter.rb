#See http://blogs.agilefaqs.com/2009/07/08/refactoring-teaser-part-1/

class StringSplitter
  REGEX_TO_SPLIT_ALONG_WHITESPACES = /\s+/
 
  def split input, number
    list_of_keywords = ""
    count = 0
    strings = input.split REGEX_TO_SPLIT_ALONG_WHITESPACES
    all_strings = single_double_triple_words strings
    size = all_strings.size
    all_strings.each do |phrase|
      break if count == number
      list_of_keywords += "'" + phrase + "'"
      count += 1
      if count < size && count < number
        list_of_keywords += ", "
      end
    end
    list_of_keywords
  end
 
  private
 
  def single_double_triple_words strings
    all_strings = []
    num_words = strings.size
 
    return all_strings unless has_enough_words num_words
 
    # Extracting single words. Total size of words == num_words
 
    # Extracting single-word phrases.
    (0...num_words).each do |i|
      all_strings << strings[i]
    end
 
    # Extracting double-word phrases
    (0...num_words - 1).each do |i|
      all_strings << "#{strings[i]} #{strings[i + 1]}"
    end
 
    # Extracting triple-word phrases
    (0...num_words - 2).each do |i|
      all_strings << "#{strings[i]} #{strings[i + 1]} #{strings[i + 2]}"
    end
    return all_strings
  end
  
  def has_enough_words num_words
    num_words >= 3
  end
end
