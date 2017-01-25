
# Backtracking
# https://en.wikipedia.org/wiki/Backtracking

module Backtracking

  def self.permutations(s)
    n = s.length
    a = s.split('')
    permute(a, 0, n-1)
  end

  def self.permute(a, l, r)
    if l == r
      puts a.join
    else
      (l..r).each do |i|
        a[l], a[i] = a[i], a[l]
        permute(a.clone, l+1, r)
        a[l], a[i] = a[i], a[l]
      end
    end
  end

  def self.test
    permutations("abcd")
  end
end

def process_input(text)
  Backtracking.permutations(text)
end

puts process_input(ARGV[0]) if __FILE__==$0

# usage
# $ irb
# > require './backtracking.rb'
# > Backtracking.test
# > Backtracking.permutations('abcd')

# or
# ruby backtracking.rb abcd
