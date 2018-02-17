
# A* Search Algorithm
# https://en.wikipedia.org/wiki/A*_search_algorithm

require './algorithms/priority_queue.rb'
require './algorithms/grids.rb'

module AstarSearch

  def self.astar(grid, source, target, neighborship = 'neighbors4')
    frontier = PriorityQueue.new
    frontier.push(source, 0)

    previous = {}
    cost = {}
    previous[source.key] = nil
    cost[source.key] = 0

    while !frontier.empty?
      current = frontier.pop.first
      return if current == target

      neighbors = grid.send(neighborship, current)
      neighbors.reject! { |neighbor| grid[neighbor.y][neighbor.x] != 0 }
      neighbors.each do |neighbor|
        new_cost = cost[current.key] + Grid.cityblock_distance(current, neighbor)
        if !cost.keys.include?(neighbor.key) || new_cost < cost[neighbor.key]
          cost[neighbor.key] = new_cost
          priority = new_cost + Grid.cityblock_distance(target, neighbor)
          frontier.push(neighbor, priority)
          previous[neighbor.key] = current.key
        end
      end
    end
    return previous, cost
  end

  def self.shortest_path(grid, source, target, neighborship = 'neighbors4')
    previous, cost = astar(grid, source, target, neighborship)
    result = [target.key]
    node = target.key
    while previous[node]
      result << previous[node]
      node = previous[node]
    end
    result.reverse
  end

  def self.test
    array = [[0, 0, 0, 0, 0, 1],
             [1, 1, 0, 0, 0, 1],
             [0, 0, 0, 1, 0, 0],
             [0, 1, 1, 0, 0, 1],
             [0, 1, 0, 0, 1, 0],
             [0, 1, 0, 0, 0, 0]]
    grid = Grid.new_from_array(array)
    grid.print

    result = shortest_path(grid, Point.new(0,0), Point.new(5,5))
    puts "shortest path from top left to bottom right:"
    puts result.join("\n")

    grid.mark_points(result)
    grid.print
  end
end

# usage
# $ irb
# > require './algorithms/astar_search.rb'
# > AstarSearch.test
