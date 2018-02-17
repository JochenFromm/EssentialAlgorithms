require './algorithms/map_reduce.rb'

RSpec.describe MapReduce do
  describe 'frequency function' do
    let(:text) {
      'And so even though we face the difficulties of today '+
      'and tomorrow, I still have a dream. It is a dream '+
      'deeply rooted in the American dream.'
    }

    it 'calculates letter frequency' do
      chars = {
        'k' => 1,
        'i' => 1,
        't' => 2,
        'e' => 1,
        'n' => 1
      }
      expect(MapReduce.letter_frequency('kitten', 0)).to eq(chars)

      chars = {
        ' ' => 26,
        'a' => 12,
        'e' => 15,
      }
      expect(MapReduce.letter_frequency(text, 10)).to eq(chars)
    end

    it 'calculates word frequency' do
      words = {
        "yes" => 3,
        "we" => 2
      }
      expect(MapReduce.word_frequency('Yes yes yes we can. We can do it', 1)).to eq(words)

      words = {
        'and' => 2,
        'the' => 2,
        'a' => 2,
        'dream.' => 2
      }
      expect(MapReduce.word_frequency(text, 1)).to eq(words)
    end
  end
end
