require './algorithms/astar_search.rb'

RSpec.describe AstarSearch do
  describe 'finds a path from top left to bottom right in a square maze' do
    let(:grid) do
      array = [[0, 0, 0, 0, 0, 1],
               [1, 0, 0, 0, 0, 1],
               [0, 0, 1, 1, 0, 0],
               [0, 1, 1, 0, 0, 1],
               [0, 1, 0, 0, 1, 1],
               [0, 1, 0, 0, 0, 0]]
      Grid.new_from_array(array)
    end

    context '4 neighbors' do
      let(:neighbors) { 'neighbors4' }

      it 'finds a short path' do
        result = AstarSearch.shortest_path(grid, Point.new(0,0), Point.new(5,5), neighbors)
        path = ['0-0', '1-0', '1-1', '2-1', '3-1', '4-1', '4-2', '4-3', '3-3', '3-4', '3-5', '4-5', '5-5']
        expect(result).to eq(path)

        x = '.'
        way_to_goal = [[x, x, 0, 0, 0, 1],
                       [1, x, x, x, x, 1],
                       [0, 0, 1, 1, x, 0],
                       [0, 1, 1, x, x, 1],
                       [0, 1, 0, x, 1, 1],
                       [0, 1, 0, x, x, x]]
        solution = Grid.new_from_array(way_to_goal)
        grid.mark_points(result)
        expect(grid.nodes).to eq(solution.nodes)
      end
    end

    context '8 neighbors' do
      let(:neighbors) { 'neighbors8' }

      it 'finds a short path' do
        result = AstarSearch.shortest_path(grid, Point.new(0,0), Point.new(5,5), neighbors)
        path = ['0-0', '1-1', '2-1', '3-1', '4-2', '3-3', '3-4', '4-5', '5-5']
        expect(result).to eq(path)

        x = '.'
        way_to_goal = [[x, 0, 0, 0, 0, 1],
                       [1, x, x, x, 0, 1],
                       [0, 0, 1, 1, x, 0],
                       [0, 1, 1, x, 0, 1],
                       [0, 1, 0, x, 1, 1],
                       [0, 1, 0, 0, x, x]]
        solution = Grid.new_from_array(way_to_goal)
        grid.mark_points(result)
        expect(grid.nodes).to eq(solution.nodes)
      end
    end

  end

  describe 'path from top left to bottom right in a rectangular maze' do
    let(:grid) do
      array = [[0, 0, 0, 0, 1, 1, 1, 1],
               [0, 0, 0, 0, 0, 1, 1, 1],
               [1, 1, 0, 1, 1, 0, 0, 0],
               [1, 0, 0, 0, 0, 0, 0, 0]]
      Grid.new_from_array(array)
    end

    context '4 neighbors' do
      let(:neighbors) { 'neighbors4' }

      it 'finds a short path' do
        result = AstarSearch.shortest_path(grid, Point.new(0,0), Point.new(7,3), neighbors)
        path = ['0-0', '0-1', '1-1', '2-1', '2-2', '2-3', '3-3', '4-3', '5-3', '6-3', '7-3']
        expect(result).to eq(path)

        x = '.'
        way_to_goal = [[x, 0, 0, 0, 1, 1, 1, 1],
                       [x, x, x, 0, 0, 1, 1, 1],
                       [1, 1, x, 1, 1, 0, 0, 0],
                       [1, 0, x, x, x, x, x, x]]
        solution = Grid.new_from_array(way_to_goal)
        grid.mark_points(result)
        expect(grid.nodes).to eq(solution.nodes)
      end
    end

    context '8 neighbors' do
      let(:neighbors) { 'neighbors8' }

      it 'finds a short path' do
        result = AstarSearch.shortest_path(grid, Point.new(0,0), Point.new(7,3), neighbors)
        path = ['0-0', '1-1', '2-2', '3-3', '4-3', '5-3', '6-3', '7-3']
        expect(result).to eq(path)

        x = '.'
        way_to_goal = [[x, 0, 0, 0, 1, 1, 1, 1],
                       [0, x, 0, 0, 0, 1, 1, 1],
                       [1, 1, x, 1, 1, 0, 0, 0],
                       [1, 0, 0, x, x, x, x, x]]
        solution = Grid.new_from_array(way_to_goal)
        grid.mark_points(result)
        expect(grid.nodes).to eq(solution.nodes)
      end
    end
  end
end
