
# Dynamic Programming
# https://en.wikipedia.org/wiki/Dynamic_programming

module DynamicProgramming

  # Input:
  # Values (stored in array v)
  # Weights (stored in array w)
  # Knapsack capacity (c)
  def self.knapsack(v, w, c)
    cost = Array.new(c+1, 0)
    best = Array.new(c+1, ' ')
    n = v.length
    (0..n-1).each do |j|
      (1..c).each do |i|
        if ((i - w[j]) >= 0) then
          new_cost = cost[i - w[j]] + v[j]
          if cost[i] < new_cost then
            cost[i] = new_cost
            best[i] = j
          end
        end
      end
      puts "Cost = #{cost.drop(1).join('-')}"
      puts "Best = #{best.drop(1).join('-')}"
    end

    size = c
    result = []
    while size > 0 && size != ' '
      result << best[size]
      weight = w[best[size]]
      size = size - weight
    end
    puts "Content of knapsack:"
    puts "value #{result.map{ |x| v[x]}.reduce(&:+) }"
    puts "weight #{result.map{ |x| w[x]}.reduce(&:+) }"
    return result
  end

  def self.test
    v = [4, 5, 10, 11, 13]
    w = [3, 4, 7, 8, 9]
    knapsack(v, w, 120)
  end
end

# usage
# $ irb
# > require './algorithms/DynamicProgramming.rb'
# > DynamicProgramming.test

