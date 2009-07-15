#!/usr/bin/env ruby
#
#See http://blogs.agilefaqs.com/2009/07/08/refactoring-teaser-part-1/

require 'spec'

module StringExtensions
  def phrases(number)
    words = split
    all_strings = words
    (2..words.size).each do |phrase_length|
      break if all_strings.length >= number
      all_strings += extract_phrases(words, phrase_length)
    end
    all_strings[0, number].map {|s| "'#{s}'"}.join(', ')
  end
 
  private
 
  def extract_phrases(words, phrase_length)
    (0...words.size - phrase_length + 1).map do |i|
      words[i, phrase_length].join(' ')
    end
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

