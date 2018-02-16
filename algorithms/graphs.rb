class Node
  attr_accessor :neighbors, :name, :distance, :previous, :visited

  def initialize(opts = {})
    @name = opts[:name]
    @neighbors = []
    @previous = nil
    @distance = 0
    @visited = false
  end
end

class Graph
  attr_accessor :nodes, :matrix

  def adjacency_matrix
    @matrix
  end

  # opts = {nodes: nodes}
  # where nodes is either an array with node names and weights
  # nodes: [['a', 'b', 4],
  #         ['a', 'h', 8],
  #         ['b', 'h', 11]
  # or an hash with connections of equal weight
  # nodes: {'a' => ['b', 'h']}
  #         'b' => 'h'}
  def initialize(opts = {})
    initialize_array(opts) if opts[:nodes].is_a? Array
    initialize_hash(opts) if opts[:nodes].is_a? Hash
  end

  def initialize_matrix(node_names)
    @nodes = node_names.map{ |name| Node.new name: name }
    node_count = @nodes.count
    @matrix = Array.new(node_count) { Array.new(node_count, 0) }
  end

  def initialize_hash(opts)
    node_names = (opts[:nodes].keys + opts[:nodes].values).flatten.uniq
    initialize_matrix(node_names)

    opts[:nodes].each do |source, targets|
      Array(targets).each do |target|
        node_a = find_node(source)
        node_b = find_node(target)
        add_edge(node_a, node_b, 1)
        add_edge(node_b, node_a, 1)
      end
    end
  end

  def initialize_array(opts)
    node_names = opts[:nodes].map{ |a| a.slice(0,2) }.flatten.uniq
    initialize_matrix(node_names)

    opts[:nodes].each do |node|
      node_a = find_node(node[0])
      node_b = find_node(node[1])
      add_edge(node_a, node_b, node[2])
      add_edge(node_b, node_a, node[2])
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
    @matrix[j][i] = weight
    node_a.neighbors << node_b.name
  end
end

class DirectedGraph < Graph
  def initialize_hash(opts)
    node_names = (opts[:nodes].keys + opts[:nodes].values).flatten.uniq
    initialize_matrix(node_names)

    opts[:nodes].each do |source, targets|
      Array(targets).each do |target|
        node_a = find_node(source)
        node_b = find_node(target)
        add_edge(node_a, node_b, 1)
      end
    end
  end

  def initialize_array(opts)
    node_names = opts[:nodes].map{ |a| a.slice(0,2) }.flatten.uniq
    initialize_matrix(node_names)

    opts[:nodes].each do |node|
      node_a = find_node(node[0])
      node_b = find_node(node[1])
      add_edge(node_a, node_b, node[2])
    end
  end
end

class UndirectedGraph < Graph
end
