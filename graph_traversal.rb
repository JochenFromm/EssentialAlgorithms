
# Depth-first search (DFS) and Breadth-first search (BFS)
# are algorithms for traversing or searching graph data structures.
# https://en.wikipedia.org/wiki/Depth-first_search
# https://en.wikipedia.org/wiki/Breadth-first_search

require './graphs.rb'

module GraphTraversal

  # DFS is based on a LIFO Queue (= Stack)
  def self.dfs(graph, node)
    mark_unvisited(graph)
    stack = []
    stack << node
    traversal(graph, stack)
  end

  # BFS is based on a FIFO Queue (= Queue)
  def self.bfs(graph, node)
    mark_unvisited(graph)
    queue = Queue.new
    queue << node
    traversal(graph, queue)
  end

  def self.mark_unvisited(graph)
    graph.nodes.each do |node|
      node.visited = false
    end
  end

  def self.traversal(graph, array)
    cycle = false
    result = []
    while !array.empty?
      node = array.pop
      if node.visited
        cycle = true
      else
        result << node.name
        node.visited = true
        graph.find_nodes(node.neighbors).each do |neighbor|
          array << neighbor
        end
      end
    end
    puts "cycle detected" if cycle
    return result
  end

  def self.test
    nodes = [['a', 'b', 1],
             ['a', 'h', 1],
             ['b', 'h', 1],
             ['b', 'c', 1],
             ['c', 'd', 1],
             ['d', 'e', 1],
             ['e', 'f', 1],
             ['f', 'd', 1],
             ['f', 'c', 1],
             ['f', 'g', 1],
             ['g', 'h', 1],
             ['h', 'i', 1],
             ['i', 'g', 1],
             ['i', 'c', 1]]
    graph = Graph.new(nodes: nodes)

    puts "***** DFS *****"
    result = dfs(graph, graph.find_node("a"))
    puts result.join('-')

    puts "***** BFS *****"
    result = bfs(graph, graph.find_node("a"))
    puts result.join('-')
  end
end
