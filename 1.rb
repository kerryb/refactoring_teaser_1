#!/usr/bin/env ruby
#
#See http://blogs.agilefaqs.com/2009/07/08/refactoring-teaser-part-1/

require 'spec'

module StringExtensions
  def phrases(number)
    words = split
    all_strings = words
    all_strings += double_words(words)
    all_strings += triple_words(words)
    all_strings[0, number].map {|s| "'#{s}'"}.join(', ')
  end
 
  private
 
  def double_words(strings)
    all_strings = []
 
    # Extracting double-word phrases
    (0...strings.size - 1).each do |i|
      all_strings << "#{strings[i]} #{strings[i + 1]}"
    end
    return all_strings
  end
 
  def triple_words(strings)
    all_strings = []
 
    (0...strings.size - 2).each do |i|
      all_strings << "#{strings[i]} #{strings[i + 1]} #{strings[i + 2]}"
    end
    return all_strings
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

