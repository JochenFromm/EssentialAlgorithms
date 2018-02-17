require './algorithms/dynamic_programming.rb'

RSpec.describe DynamicProgramming do
  describe 'lcs' do
    it 'finds longest common subsequence' do
      s = 'AGGTAB'
      t = 'GXTXAYB'
      expect(DynamicProgramming.lcs(s,t)).to eq('GTAB')

      s = 'ABCDGH'
      t = 'AEDFHR'
      expect(DynamicProgramming.lcs(s,t)).to eq('ADH')

      s = 'HUMAN'
      t = 'CHIMPANZEE'
      expect(DynamicProgramming.lcs(s,t)).to eq('HMAN')

      s = 'ACCGGTCGAGTGCGCGGAAGCCGGCCGAA'
      t = 'GTCGTTCGGAATGCCGTTGCTCTGTAAA'
      expect(DynamicProgramming.lcs(s,t)).to eq('GTCGTCGGAAGCCGGCCGAA')
    end
  end
end
