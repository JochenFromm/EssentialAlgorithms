
# Levenshtein Distance
# https://en.wikipedia.org/wiki/Levenshtein_distance

module Levenshtein

  def self.distance(s, t)
    return nil unless s && t
    s, t = s.downcase, t.downcase

    # for all i and j, d[i][j] will hold the Levenshtein distance between
    # the first i characters of s and the first j characters of t
    # note that d has (m+1)*(n+1) values
    d = Array.new(s.length+1) { Array.new(t.length+1, 0) }

    (1..s.length).each { |i| d[i][0] = i }
    (1..t.length).each { |j| d[0][j] = j }
    (1..t.length).each do |j|
      (1..s.length).each do |i|
        subst_cost = (s[i-1] == t[j-1]) ? 0 : 1
        deletion     = d[i-1][  j] + 1
        insertion    = d[i  ][j-1] + 1
        substitution = d[i-1][j-1] + subst_cost
        d[i][j] = [deletion, insertion, substitution].min
      end
    end
    d[s.length][t.length]
  end

  def self.test
    %w{kitten sitting kitten kitchen kitten kitten!}.each_slice(2) do |s, t|
      puts "distance(#{s}, #{t}) = #{distance(s, t)}"
    end
  end
end

def process_input(*args)
  Levenshtein.distance(args.first, args.last)
end

puts process_input(ARGV[0], ARGV[1]) if __FILE__==$0

# usage
# $ irb
# > require './levenshtein.rb'
# > Levenshtein.test
# > Levenshtein.distance('kitten', 'kitchen')

# or
# ruby levenshtein.rb kittchen kitchen
