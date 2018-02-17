require './algorithms/levenshtein.rb'

RSpec.describe Levenshtein do
  describe 'distance' do
    it 'calculates similarity of strings' do
      h = {
        ['kitten', 'fetching'] => 6,
        ['kitten', 'knowing'] => 5,
        ['kitten', 'sitting'] => 3,
        ['kitten', 'kitchen'] => 2,
        ['kitten', 'kitten!'] => 1,
        ['kitten', 'kitten'] => 0,
      }
      h.each do |text, distance|
        expect(Levenshtein.distance(text.first, text.last)).to eq(distance)
      end
    end
  end
end
