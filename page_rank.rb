
# PageRank
# https://en.wikipedia.org/wiki/PageRank
# and http://www.ams.org/samplings/feature-column/fcarc-pagerank

require './graphs.rb'
require 'matrix'

module PageRank

  def self.calculate(graph, d = 0.85)
    nodes = graph.nodes.length
    page_rank = Vector.elements([d]*nodes)
    link_matrix = link_matrix(graph)

    100.times do |i|
      v = Vector.elements([1 - d] * nodes)
      new_page_rank = v + d * ( link_matrix * page_rank )
      break if distance(new_page_rank, page_rank) < 0.1
      page_rank = new_page_rank
    end

    node_list(graph, page_rank)
  end

  def self.distance(v1, v2)
    Math.sqrt(v1.zip(v2).map { |v1, v2| (v1 - v2)**2 }.reduce(&:+))
  end

  def self.link_matrix(graph)
    rows = []
    graph.nodes.each_with_index do |node, i|
      row = []
      graph.matrix[i].each_with_index do |link, j|
        count = graph.nodes[j].neighbors.length
        row << ((link > 0) && (count > 0) ? 1 / count.to_f : 0)
      end
      rows << row
    end
    Matrix.rows(rows)
  end

  def self.node_list(graph, vector)
    result = {}
    vector.each_with_index do |rank, index|
      node_name = graph.nodes[index].name
      result[node_name] = rank
    end
    result
  end

  # alternative option: use eigenvectors
  def self.eigenvector_pagerank(graph)
    nodes = graph.nodes.length
    link_matrix = link_matrix(graph)

    # get eigenvalue closest to 1
    eigenvalues = link_matrix.eigen.eigenvalues
    eigenvalue1 = eigenvalues.min_by { |x| (x.abs.to_f - 1).abs }
    i = link_matrix.eigen.eigenvalues.index(eigenvalue1)

    # get eigenvector for this eigenvalue
    page_rank = link_matrix.eigen.eigenvectors[i]
    page_rank = page_rank / page_rank.min

    node_list(graph, page_rank)
  end

  def self.test
    nodes = {'d' => ['a','b'],
     'b' => ['c'],
     'c' => ['b'],
     'e' => ['d','b','f'],
     'f' => ['b']}
    graph = DirectedGraph.new(nodes: nodes)
    puts "Graph: #{nodes}"
    puts PageRank::calculate(graph)

    nodes = {'a' => ['b','c'],
     'b' => ['c'],
     'c' => ['a'],
     'd' => ['c']}
    graph = DirectedGraph.new(nodes: nodes)
    puts "Graph: #{nodes}"
    puts PageRank::calculate(graph)
  end
end
