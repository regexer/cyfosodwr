#!/usr/bin/env ruby

require 'sinatra'
require './lib/word_assembler.rb'
require 'json'

words = WordAssembler.new './data/enable2k.txt'
words.load_trie

get '/' do
  headers['Content-Type'] = 'text/plain'
  <<HELP
  Call the service like this:

  #{uri}words.json?letters=BRIDGES
HELP
end

get '/words.?:format?' do
  letters = params['letters'].upcase
  if letters.length > 21
    content_type 'text'
    return "Sorry, I can't handle more than 21 letters."
  end
  matches = (words.get_matches letters).sort_by{|w| w.length}.reverse
  if params['format'] == 'json'
    content_type 'json'
    { :words => matches }.to_json
  else
    content_type 'text'
    matches.join(',')
  end
end


