class Node
  attr_accessor :neighbors
  attr_accessor :name

  def initialize(opts = {})
    @name = opts[:name]
    @neighbors = []
  end
end

class Graph
  attr_accessor :nodes, :matrix

  def adjacency_matrix
    @matrix
  end

  def initialize(opts = {})
    node_names = opts[:nodes].map{ |a| a.slice(0,2) }.flatten.uniq
    @nodes = node_names.map{ |name| Node.new name: name }
    node_count = node_names.count
    @matrix = Array.new(node_count) { Array.new(node_count, 0) }

    opts[:nodes].each do |node|
      node_a = find_node(node[0])
      node_b = find_node(node[1])
      add_edge(node_a, node_b, node[2])
    end
  end

  def find_node(name)
    @nodes.find { |node| node.name == name}
  end

  def add_edge(node_a, node_b, weight)
    i = @nodes.index(node_a)
    j = @nodes.index(node_b)
    @matrix[i][j] = weight
    @matrix[j][i] = weight
    node_a.neighbors << node_b.name
    node_b.neighbors << node_a.name
  end
end

