require './algorithms/graph_traversal.rb'

RSpec.describe GraphTraversal do
  describe 'bfs and dfs' do
    it 'knows dfs and bfs for small graphs' do
      nodes = [['a', 'b', 1],
               ['a', 'c', 1],
               ['c', 'd', 1],
               ['b', 'd', 1],
               ['d', 'e', 1],
               ['e', 'd', 1]]
      events = []
      graph = Graph.new(nodes: nodes)
      result = GraphTraversal.dfs(graph, graph.find_node('a')) do |event|
        events << event
      end
      expect(result.join('-')).to eq('a-c-d-e-b')
      expect(events).to eq(['cycle detected'])

      events = []
      graph = Graph.new(nodes: nodes)
      result = GraphTraversal.bfs(graph, graph.find_node('a')) do |event|
        events << event
      end
      expect(result.join('-')).to eq('a-b-c-d-e')
      expect(events).to eq(['cycle detected'])
    end

    it 'knows dfs and bfs for larger graph' do
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
      events = []
      graph = Graph.new(nodes: nodes)
      result = GraphTraversal.dfs(graph, graph.find_node('a')) do |event|
        events << event
      end
      expect(result.join('-')).to eq('a-h-i-g-f-e-d-c-b')
      expect(events).to eq(['cycle detected'])

      events = []
      graph = Graph.new(nodes: nodes)
      result = GraphTraversal.bfs(graph, graph.find_node('a')) do |event|
        events << event
      end
      expect(result.join('-')).to eq('a-b-h-c-g-i-d-f-e')
      expect(events).to eq(['cycle detected'])
    end

    it 'finds one strongly connected component' do
      nodes = [['a', 'b', 1],
               ['a', 'c', 1],
               ['c', 'd', 1],
               ['b', 'd', 1],
               ['d', 'e', 1],
               ['e', 'b', 1]]
      graph = DirectedGraph.new(nodes: nodes)
      components = []
      result = GraphTraversal.scc(graph, graph.find_node('a')) do |event|
        components << event
      end
      expect(components).to eq(['e-d-b', 'c', 'a'])
    end

    it 'finds two strongly connected components' do
      nodes = [['a', 'b', 1],
               ['a', 'c', 1],
               ['a', 'f', 1],
               ['c', 'd', 1],
               ['b', 'd', 1],
               ['d', 'e', 1],
               ['e', 'b', 1],
               ['f', 'c', 1],
               ['c', 'g', 1],
               ['g', 'f', 1],
               ['g', 'd', 1]]
      graph = DirectedGraph.new(nodes: nodes)
      components = []
      result = GraphTraversal.scc(graph, graph.find_node('a')) do |event|
        components << event
      end
      expect(components).to eq(['e-d-b', 'f-g-c', 'a'])
    end
  end
end
