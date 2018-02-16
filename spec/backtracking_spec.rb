require './algorithms/backtracking.rb'

RSpec.describe Backtracking do
  it 'calculates permutations' do
    permutations = %w(abc acb bac bca cba cab)

    result = []
    Backtracking.permutations("abc") do |permutation|
      result << permutation
    end
    expect(result.size).to eq(2*3)
    expect(result).to eq(permutations)
  end

  it 'calculates permutations' do
    permutations = %w(abcd abdc acbd acdb adcb adbc bacd badc bcad
                      bcda bdca bdac cbad cbda cabd cadb cdab cdba
                      dbca dbac dcba dcab dacb dabc)

    result = []
    Backtracking.permutations("abcd") do |permutation|
      result << permutation
    end
    expect(result.size).to eq(2*3*4)
    expect(result).to eq(permutations)
  end
end
