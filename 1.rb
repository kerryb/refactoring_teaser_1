#!/usr/bin/env ruby
#
#See http://blogs.agilefaqs.com/2009/07/08/refactoring-teaser-part-1/

require 'spec'

module StringExtensions
  def phrases(number)
    words = split
    all_strings = single_double_triple_words(words)
    all_strings[0, number].map {|s| "'#{s}'"}.join(', ')
  end
 
  private
 
  def single_double_triple_words(strings)
    all_strings = []
    num_words = strings.size
 
    return all_strings unless has_enough_words(num_words)
 
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
  
  def has_enough_words(num_words)
    num_words >= 3
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

