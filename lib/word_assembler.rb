
require 'trie'

class Array

  def func_power_set
    inject([[]]) { |ps,item|    # for each item in the Array
      ps +                      # take the powerset up to now and add
      ps.map { |e| e + [item] } # it again, with the item appended to each element
    }
  end
end

class WordAssembler
  attr_reader :trie

  def initialize filename
    load_words filename
  end

  def load_words filename
    words = File.readlines(filename)
    words.each {|w| w.gsub!(/\r\n/, '')}

    wordhash = {}
    words.collect{|w| w.length}.uniq.each{|l| wordhash[l] = []}

    words.each {|w| wordhash[w.length] << w }

    @orderedhash = {}
    words.each do |word|
      key = word.split(//).sort.join
      @orderedhash[key] = [] if @orderedhash[key].nil?
      @orderedhash[key] << word
    end

  end

  def load_trie
    @trie = Trie.new
    @orderedhash.each do |key, value|
      @trie.add key, value
    end
  end

  def permute string
    letters = split string
    powerset = letters.func_power_set
    arr = powerset.collect{|p| p.join('')}.uniq
    arr[1...arr.length].select{|a| a.length > 1}
  end

  def get_matches letters
    searches = permute letters
    searches.collect{|s| @trie.get(s) }.select{|t| !t.nil?}.flatten.sort
  end

  def split string #alphabetize
    string.split(//).sort
  end

end
