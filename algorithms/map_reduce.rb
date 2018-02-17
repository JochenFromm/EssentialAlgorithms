
# Map Reduce
# https://en.wikipedia.org/wiki/MapReduce

# MapReduce Patterns, Algorithms, and Use Cases
# https://highlyscalable.wordpress.com/2012/02/01/mapreduce-patterns/

module MapReduce

  # Count the frequency of letters in a string
  def self.letter_frequency(text)
    count_items(text, :letters)
  end

  # Count the frequency of words in a text,
  # returns Word Cloud data similar to Wordle
  def self.word_frequency(text)
    count_items(text, :words)
  end

  def self.count_items(string, item = :letters)
    # map phase
    separator = (item == :letters) ? '' : ' '
    items = string.split(separator)

    # reduce phase
    Hash.new(0).tap do |frequency|
      items.each { |item| frequency[item.downcase] += 1 }
    end
  end

  def self.map_reduce_count(string, item = :letters)
    # map phase
    separator = (item == :letters) ? '' : ' '
    items = string.split(separator)
    items.map! { |item| [item.downcase, 1] }

    # reduce phase
    frequency = Hash.new(0)
    items.reduce(frequency) do |result, value|
      result[value.first] += value.last
      result
    end
    frequency
  end

  def self.test
    %w{kitten sitting kitchen}.each do |s|
      puts "letter_frequency('#{s}') = #{letter_frequency(s)}"
    end

    ["Yes Yes we can do it. Yes we can"].each do |s|
      puts "word_frequency('#{s}') = #{word_frequency(s)}"
    end
  end
end

def process_input(filename)
  text = File.read(filename)
  MapReduce.word_frequency(text)
end

puts process_input(ARGV[0]) if __FILE__==$0

# usage
# $ irb
# > require './algorithms/map_reduce.rb'
# > MapReduce.test

# or
# ruby map_reduce.rb examples/example.txt
