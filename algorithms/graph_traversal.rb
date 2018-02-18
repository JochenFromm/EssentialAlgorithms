
# Depth-first search (DFS) and Breadth-first search (BFS)
# are algorithms for traversing or searching graph data structures.
# https://en.wikipedia.org/wiki/Depth-first_search
# https://en.wikipedia.org/wiki/Breadth-first_search

require './algorithms/graphs.rb'

module GraphTraversal

  def self.scc(graph, node, &block)
    index = 0
    stack = []
    mark(graph, :visited, false)

    tarjan = lambda do |node|
      node.index = index
      node.lowlink = index
      index += 1
      stack.push(node)
      node.visited = true

      graph.find_nodes(node.neighbors).each do |neighbor|
        if !neighbor.visited
          tarjan.call(neighbor)
          node.lowlink = [node.lowlink, neighbor.lowlink].min
        elsif stack.include?(neighbor)
          node.lowlink = [node.lowlink, neighbor.index].min
        end
      end

      if node.lowlink == node.index && block
        component = []
        begin
          element = stack.pop
          component << element.name
        end while element != node
        block.call component.join('-')
      end
    end

    graph.nodes.each do |node|
      tarjan.call(node) unless node.visited
    end
  end

  # DFS is based on a LIFO Queue (= Stack)
  def self.dfs(graph, node, &block)
    mark(graph, :visited, false)
    stack = []
    stack << node
    traversal(graph, stack, &block)
  end

  # BFS is based on a FIFO Queue (= Queue)
  def self.bfs(graph, node, &block)
    mark(graph, :visited, false)
    queue = Queue.new
    queue << node
    traversal(graph, queue, &block)
  end

  def self.mark(graph, attribute, value)
    graph.nodes.each do |node|
      node.send("#{attribute}=", value)
    end
  end

  def self.traversal(graph, array, &block)
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
    block.call "cycle detected" if cycle && block
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
    result = dfs(graph, graph.find_node("a")) do |event|
      puts event
    end
    puts result.join('-')

    puts "***** BFS *****"
    result = bfs(graph, graph.find_node("a")) do |event|
      puts event
    end
    puts result.join('-')
  end
end
