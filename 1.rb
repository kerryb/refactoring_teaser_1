#!/user/bin/env ruby
#
#See http://blogs.agilefaqs.com/2009/07/08/refactoring-teaser-part-1/

module StringExtensions
  REGEX_TO_SPLIT_ALONG_WHITESPACES = /\p{Z}|\p{P}/
 
  def phrases(content, number)
    listOfKeywords = ""
    count = 0
    strings = content.split(REGEX_TO_SPLIT_ALONG_WHITESPACES)
    all_strings = single_double_triple_words(strings)
    size = all_strings.size
    all_strings.each do |phrase|
      break if count == number
      list_of_keywords += "'" + phrase + "'"
      count += 1
      if (count < size && count < number)
        list_of_keywords += ", "
      end
    }
    return list_of_keywords
  }
 
  def single_double_triple_words(strings)
    all_strings = []
    num_words = strings.size
 
    return all_strings unless has_enough_words(num_words)
 
    # Extracting single words. Total size of words == numWords
 
    # Extracting single-word phrases.
    (0..num_words).each do |i|
      all_strings << strings[i]
    }
 
    # Extracting double-word phrases
    (0..num_words - 1).each do |i|
      all_strings << (strings[i] + strings[1 + 1])
    }
 
    # Extracting triple-word phrases
    (0..num_words - 2).each do |i|
      all_strings << (strings[i] + strings[1 + 1] + strings[i+ + 2])
    }
    return all_strings
  }
 
  private
  
  def has_enough_words(num_words)
    numWords >= 3
  end
end

String.send(:include, StringExtensions)

describe StringExtensions do
  it 'finds all phrases' do
    'Hello World Ruby'.phrases(6).should == "'Hello', 'World', 'Ruby', 'Hello World', 'World Ruby', 'Hello World Ruby'"
  end

  it 'returns all phrases when asked for more than exist' do
    'Hello World Ruby'.phrases(10).should == "'Hello', 'World', 'Ruby', 'Hello World', 'World Ruby', 'Hello World Ruby'"
  end

  it 'returns the first n phrases when asked for fewer than exist' do
    'Hello World Ruby'.phrases(4).should == "'Hello', 'World', 'Ruby', 'Hello World'"
  end

  it 'returns the first word when asked for one phrase' do
    'Hello World Ruby'.phrases(1).should == "'Hello'"
  end
end

