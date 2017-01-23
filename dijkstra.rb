
# Dijkstra's_algorithm
# https://en.wikipedia.org/wiki/Dijkstra's_algorithm

require './graphs.rb'

module Dijkstra

  def self.shortest_path(graph, source, target)
    # TO DO
  end

  def self.test
    nodes = [["a", "b", 7],
             ["a", "c", 9],
             ["a", "f", 14],
             ["b", "c", 10],
             ["b", "d", 15],
             ["c", "d", 11],
             ["c", "f", 2],
             ["d", "e", 6],
             ["e", "f", 9]]
    graph = Graph.new(nodes: nodes)
  end

end
