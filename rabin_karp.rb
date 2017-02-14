
# Rabin Karp
# https://en.wikipedia.org/wiki/Rabin-Karp_algorithm

module RabinKarp

  def self.basic_index(s, pattern)
    n = s.length
    m = pattern.length
    pattern_hash = hash_func(pattern)

    (0..n-m).each do |i|
      sub_str = s[i, m]
      h = hash_func(sub_str)
      if h == pattern_hash
        return i if sub_str == pattern
      end
    end
    return nil
  end

  def self.index(s, pattern)
    n = s.length
    m = pattern.length
    pattern_hash = hash_func(pattern)

    old_sub_str = s[0, m]
    h = hash_func(old_sub_str)
    (0..n-m).each do |i|
      sub_str = s[i, m]
      h = rolling_hash_func(sub_str, old_sub_str, h) if i > 0
      if h == pattern_hash
        return i if s[i..i+m-1] == pattern
      end
      old_sub_str = sub_str
    end
    return nil
  end

  def self.hash_func(s, base = 101)
    rabin_fingerprint(s)
  end

  def self.rolling_hash_func(s, old_s, old_hash, base = 101)
    n = s.length-1
    old_char = old_s[0]
    new_char = s[n]
    hash = (old_hash - (old_char.ord * 101**n)) * base + new_char.ord
  end

  def self.rabin_fingerprint(s, base = 101)
    r = 0
    n = s.length-1
    s.split('').each_with_index do |c,i|
      r += c.ord * 101**(n-i)
    end
    r
  end

  def self.test
    h = {
      "test if this works" => "test",
      "this is a test" => "test"
    }
    h.each do |string, pattern|
      puts "position of '#{pattern}' in '#{string}' = #{index(string, pattern)}"
    end
  end
end

def process_input(filename, pattern)
  text = File.read(filename)
  RabinKarp.index(text, pattern)
end

puts process_input(ARGV[0], ARGV[1]) if __FILE__==$0


# usage
# $ irb
# > require './rabin_karp.rb'
# > RabinKarp.test
# > RabinKarp.index('test if this works', 'test')

# or
# ruby rabin_karp.rb examples/example.txt "George Washington"

