class Node
  attr_accessor :neighbors, :name, :distance, :previous

  def initialize(opts = {})
    @name = opts[:name]
    @neighbors = []
    @previous = nil
    @distance = 0
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

  def find_nodes(names)
    @nodes.select { |node| names.include?(node.name) }
  end

  def distance(node_a, node_b)
    i = @nodes.index(node_a)
    j = @nodes.index(node_b)
    @matrix[i][j]
  end

  def node_with_min_distance(list)
    min = list.map{ |node| node.distance }.min
    list.select{ |node| node.distance == min }.first
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

