
# Map Reduce
# https://en.wikipedia.org/wiki/MapReduce

# MapReduce Patterns, Algorithms, and Use Cases
# https://highlyscalable.wordpress.com/2012/02/01/mapreduce-patterns/

module MapReduce

  # Count the frequency of letters in a string
  def self.letter_frequency(text, min = 3)
    result = count_items(text, :letters)
    result.select { |key, value| value > min }
  end

  # Count the frequency of words in a text,
  # returns Word Cloud data similar to Wordle
  def self.word_frequency(text, min = 3)
    result = count_items(text, :words)
    result.select { |key, value| value > min }
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
end

def process_input(filename)
  text = File.read(filename)
  MapReduce.word_frequency(text)
end

puts process_input(ARGV[0]) if __FILE__==$0

# usage
# $ irb
# > require './algorithms/map_reduce.rb'
# > MapReduce.letter_frequency('kitten', 0)
# > MapReduce.word_frequency('Yes yes yes we can', 0)

# or
# ruby algorithms/map_reduce.rb examples/example.txt
