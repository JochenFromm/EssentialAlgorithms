require './algorithms/knn.rb'

RSpec.describe Knn do
  describe 'get_classification' do
    let(:data) {
      [{
       'title' => 'Jaws',
       'year' => 1975,
       'director' => 'Steven Spielberg',
       'cast' => 'Roy Scheider, Robert Shaw, Richard Dreyfuss',
       'genre' => 'Thriller, Adventure',
      },{
       'title' => 'Jaws 2',
       'year' => 1978,
       'director' => 'Jeannot Szwarc',
       'cast' => 'Roy Scheider, Murray Hamilton, Lorraine Gary',
       'genre' => 'Thriller',
      },{
       'title' => 'Indiana Jones and the Last Crusade',
       'year' => 1989,
       'director' => 'Steven Spielberg',
       'cast' => 'Harrison Ford, Sean Connery',
       'genre' => 'Action Adventure',
      },{
       'title' => 'Jurassic Park',
       'year' => 1993,
       'director' => 'Steven Spielberg',
       'cast' => 'Sam Neill, Laura Dern, Jeff Goldblum, Richard Attenborough',
       'genre' => 'Adventure',
      },{
       'title' => 'The Lost World: Jurassic Park',
       'year'=>1997,
       'director' => 'Steven Spielberg',
       'cast' => 'Jeff Goldblum, Julianne Moore, Richard Attenborough',
       'genre' => 'Science fiction',
      },{
       'title' => 'Jurassic Park III',
       'year'=>2001,
       'director' => 'Joe Johnston',
       'cast' => 'Sam Neill, William H. Macy, Trevor Morgan',
       'genre' => 'Science fiction',
      }]
    }

    it 'gets top dimensions' do
      dimensions = {
        'year' =>  [],
        'genre' => ['Thriller', 'Adventure', 'Science fiction'],
        'cast'  =>  ['Roy Scheider', 'Sam Neill', 'Jeff Goldblum', 'Richard Attenborough']
      }
      expect(Knn.get_top_dimensions(data, %w(year genre cast), 1)).to eq(dimensions)
    end

    it 'gets feature vector' do
      dimensions = Knn.get_top_dimensions(data, %w(year genre cast), 1)
      vector = [1, 1, 0, 1, 0, 0, 0]
      expect(Knn.get_classification(data[0], dimensions)).to eq(vector)
    end

    it 'gets feature vector explanation' do
      dimensions = Knn.get_top_dimensions(data, %w(year genre cast), 1)
      vector = [1, 1, 0, 1, 0, 0, 0]
      expect(Knn.explain_classification(vector, dimensions)).to eq(
        ['Thriller', 'Adventure', 'Roy Scheider']
      )
    end

    it 'gets feature vector list' do
      dimensions = Knn.get_top_dimensions(data, %w(year genre cast), 1)
      list = [
        [1, 1, 0, 1, 0, 0, 0],
        [1, 0, 0, 1, 0, 0, 0],
        [0, 1, 0, 0, 0, 0, 0],
        [0, 1, 0, 0, 1, 1, 1],
        [0, 0, 1, 0, 0, 1, 1],
        [0, 0, 1, 0, 1, 0, 0]
      ]
      expect(Knn.get_feature_vector_list(data, dimensions)).to eq(list)
    end

    it 'gets similar items' do
      list = [
        [1, 1, 0, 1, 0, 0, 0],
        [1, 0, 0, 1, 0, 0, 0],
        [0, 1, 0, 0, 0, 0, 0],
        [0, 1, 0, 0, 1, 1, 1],
        [0, 0, 1, 0, 0, 1, 1],
        [0, 0, 1, 0, 1, 0, 0]
      ]
      vector = list[0]
      expect(Knn.similar_items(vector, list, 0)).to eq([0])
      expect(Knn.similar_items(vector, list, 1)).to eq([0, 1])
      expect(Knn.similar_items(vector, list, 2)).to eq([0, 1, 2])
      expect(Knn.similar_items(vector, list, 3)).to eq([0, 1, 2, 3, 4, 5])
    end
  end
end
