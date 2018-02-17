require './algorithms/rabin_karp.rb'

RSpec.describe RabinKarp do
  describe 'search' do
    it 'finds sub strings' do
      h = {
        'test if this works' => ['test', 0],
        'a great test' => ['great', 2],
        'is test successful' => ['test', 3],
        'is this great test successful' => ['great', 8],
        'this is a test' => ['test', 10],
        'this is a great test' => ['test', 16]
      }
      h.each do |string, pattern|
        expect(RabinKarp.index(string, pattern.first)).to eq(pattern.last)
      end
    end

    it 'finds text in a file' do
      text = File.read('./examples/example.txt')
      expect(RabinKarp.index(text, "George Washington")).to eq(25888)
    end
  end
end
