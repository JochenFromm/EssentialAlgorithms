
# Karmarkar Karp
# https://en.wikipedia.org/wiki/Partition_problem
# http://www.americanscientist.org/issues/pub/the-easiest-hard-problem

require './priority_queue.rb'

module KarmarkarKarp

  def self.partition(set)
    pairs, diffs = pair_differences(set)
    left, right = build_sets(pairs, diffs)
    puts "left #{left}, sum #{left.inject(&:+)}"
    puts "right #{right}, sum #{left.inject(&:+)}"
    return left, right
  end

  def self.build_sets(pairs, diffs)
    left = []
    right = []
    while !diffs.empty?
      pair = pairs.pop
      diff = diffs.pop
      if left.include?(diff)
        left.delete(diff)
        left << pair.first
        right << pair.last
      else
        right.delete(diff)
        right << pair.first
        left << pair.last
      end
    end
    return left, right
  end

  def self.pair_differences(set)
    set.sort!
    pairs = []
    diffs = []
    while set.length > 1
      val_1 = set.pop
      val_2 = set.pop
      diff = val_1 - val_2
      pairs << [val_1, val_2]
      diffs << diff
      set << diff
      set.sort!
    end
    return pairs, diffs
  end

  def self.test
    set = [17, 6, 13, 9, 19]
    puts "partition #{set}"
    p = partition(set)

    set = [2, 10, 3, 8, 5, 7, 9, 5, 3, 2]
    puts "partition #{set}"
    p = partition(set)
  end
end

# usage
# $ irb
# > require './karmarkar_karp.rb'
# > KarmarkarKarp.test
