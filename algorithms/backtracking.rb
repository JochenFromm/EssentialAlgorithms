
# Backtracking
# https://en.wikipedia.org/wiki/Backtracking

module Backtracking

  def self.permutations(s, block = Proc.new)
    n = s.length
    a = s.split('')
    permute(a, 0, n-1, block)
  end

  def self.permute(a, l, r, block = Proc.new)
    if l == r
      block.call a.join
    else
      (l..r).each do |i|
        a[l], a[i] = a[i], a[l]
        permute(a.clone, l+1, r, block)
        a[l], a[i] = a[i], a[l]
      end
    end
  end

  def self.test(text = "abcd")
    permutations(text) do |permutation|
      puts permutation
    end
  end
end

def process_input(text)
  Backtracking.permutations(text)
end

puts process_input(ARGV[0]) if __FILE__==$0

# usage
# $ irb
# > require './algorithms/backtracking.rb'
# > Backtracking.permutations("abcd") { |permutation| puts permutation }

# or
# ruby algorithms/backtracking.rb abcd
