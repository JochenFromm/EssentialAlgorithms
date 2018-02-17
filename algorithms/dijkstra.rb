
# Dijkstra's_algorithm
# https://en.wikipedia.org/wiki/Dijkstra's_algorithm

require './algorithms/graphs.rb'

module Dijkstra

  def self.dijkstra(graph, source)
    graph.nodes.each do |node|
      node.distance = Float::INFINITY
      node.previous = nil
    end
    source.distance = 0

    unvisited = graph.nodes.clone
    while unvisited.length > 0
      node = graph.node_with_min_distance(unvisited)
      unvisited.delete(node)
      graph.find_nodes(node.neighbors).each do |neighbor|
        distance = graph.distance(node, neighbor)
        alternative = node.distance + distance
        if alternative < neighbor.distance
          neighbor.distance = alternative
          neighbor.previous = node
        end
      end
    end

    graph.nodes.map { |node| [node.name, node.distance] }.to_h
  end

  def self.shortest_path(graph, source, target)
    dijkstra(graph, source)
    result = [target.name]
    node = target
    while node.previous
      result << node.previous.name
      node = node.previous
    end
    result.reverse
  end

  def self.test
    nodes = [['a', 'b', 4],
             ['a', 'h', 8],
             ['b', 'h', 11],
             ['b', 'c', 8],
             ['c', 'd', 7],
             ['d', 'e', 9],
             ['e', 'f', 10],
             ['f', 'd', 14],
             ['f', 'c', 4],
             ['f', 'g', 2],
             ['g', 'h', 1],
             ['h', 'i', 7],
             ['i', 'g', 6],
             ['i', 'c', 2]]
    graph = Graph.new(nodes: nodes)

    result = dijkstra(graph, graph.find_node("a"))
    result.each do |key, value|
       puts "Node #{key} Distance #{value}"
    end

    result = shortest_path(graph, graph.find_node("a"), graph.find_node("e"))
    puts "shortest path von a to e:"
    puts result.join("-")
  end

end
