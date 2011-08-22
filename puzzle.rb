require 'rubygems'
require 'bundler'
require 'active_support/core_ext'
Bundler.setup

require 'sinatra'

get "/" do
  
  alphabet = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
  
  #Grab text lines
  lines = []
  File.open("public/complex_cipher.txt").each do |line|
      lines << line.strip unless line.strip.empty?
  end
  
  #Find the amount to shift each letter
  cypher = lines[0]
  shift = []
  cypher.each_char{|char| shift << alphabet.index(char)}
  
  #compile the message
  
  count = lines.size-1
  message = ""
  (1..count).collect {|i|
    message += lines[i] + " "
  }
  
  different_messages = []
  
  (0..26).each {|num|
    true_message = ""
    cypher_count = 0
    
    message.each_char{|char| 
      if alphabet.detect  {|i| i == char }
        if cypher_count == cypher.size
          cypher_count = 0
        end
        new_char = alphabet.index(char).to_i - shift[cypher_count.to_i] + num.to_i
        if new_char < 0
          new_char = new_char + 26
        end
        
        if new_char > 25
          new_char = new_char - 26
        end

        true_message += alphabet[new_char]

        cypher_count = cypher_count.to_i + 1
      else
        true_message += char
      end
    }
    different_messages << true_message
  }
  
  @total = different_messages
  
  erb :total
end