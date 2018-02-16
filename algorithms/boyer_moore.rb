
# Boyer Moore
# https://en.wikipedia.org/wiki/Boyer-Moore_string_search_algorithm

module BoyerMoore

  def self.distance_table(pattern)
    chars = ('0'..'9').to_a + ('a'..'z').to_a + [' ']
    table = {}
    m = pattern.length
    chars.each do |c|
      table[c] = m
    end
    pattern[0,m-1].downcase.split('').each_with_index do |c, i|
      table[c] = m-i-1
    end
    table
  end

  def self.index(s, pattern)
    table = distance_table(pattern)
    n = s.length
    m = pattern.length
    i = 0
    while i < (n-m)+1
      j = m-1
      j -= 1 while (j > 0) && (pattern[j].downcase == s[i+j].downcase)
      return i if j == 0
      x = s[i + m - 1].downcase
      i += table[x] || m
    end
    return nil
  end

  def self.test
    h = {
      "test if this works" => "test",
      "a great test" => "great",
      "is test successful" => "test",
      "is this great test successful" => "great",
      "this is a test" => "test",
      "this is a great test" => "test"
    }
    h.each do |string, pattern|
      puts "position of '#{pattern}' in '#{string}' = #{index(string, pattern)}"
    end
  end
end

def process_input(filename, pattern)
  text = File.read(filename)
  BoyerMoore.index(text, pattern)
end

puts process_input(ARGV[0], ARGV[1]) if __FILE__==$0


# usage
# $ irb
# > require './algorithms/boyer_moore.rb'
# > BoyerMoore.test
# > BoyerMoore.index('test if this works', 'test')

# or
# ruby boyer_moore.rb examples/example.txt "George Washington"

