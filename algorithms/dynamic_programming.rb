
# Dynamic Programming
# https://en.wikipedia.org/wiki/Dynamic_programming

module DynamicProgramming

  # find Longest Common Subsequence (LCS)
  def self.lcs(s, t)
    m = s.length
    n = t.length

    d = Array.new(m+1) { Array.new(n+1, 0) }

    # d[i][j] contains length of LCS of s[0..i-1] and t[0..j-1]
    (0..m).each do |i|
      (0..n).each do |j|
        if i == 0 or j == 0
          d[i][j] = 0
        elsif s[i-1] == t[j-1]
          d[i][j] = d[i-1][j-1]+1
        else
          d[i][j] = [d[i-1][j], d[i][j-1]].max
        end
      end
    end

    sequence = lambda do |i,j|
      if i == 0 || j == 0
        return []
      elsif s[i-1] == t[j-1]
        return sequence.call(i-1, j-1) + [s[i-1]]
      elsif d[i-1][j] > d[i][j-1]
        return sequence.call(i-1, j)
      else
        return sequence.call(i, j-1)
      end
    end

    # d[m][n] contains the length of LCS of s[0..n-1] & t[0..m-1]
    sequence.call(m, n).join('')
  end


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

