
# CellularAutomaton
# https://en.wikipedia.org/wiki/Cellular_automaton
# https://en.wikipedia.org/wiki/Elementary_cellular_automaton
# http://mathworld.wolfram.com/CellularAutomaton.html
# http://mathworld.wolfram.com/ElementaryCellularAutomaton.html

module Automata

  class ElementaryCA
    attr_accessor :rule, :transition, :state, :width

    DEFAULT_OPTS = {
                     rule: 30,      # from 0 to 255
                     width: 32,
                     start: :middle # :left, :middle, :right
                   }

    def initialize(opts = {})
      opts = DEFAULT_OPTS.merge(opts)
      @rule = opts[:rule]
      @width = opts[:width]

      set_transition_table(opts[:rule])
      set_initital_state(opts[:start])
    end

    def set_transition_table(rule)
      binary = '%08d' % rule.to_s(2)
      combinations = (0..7).map { |n| '%03d' % n.to_s(2) }
      @transition = combinations.map do |n|
        [n, binary.slice!(-1)]
      end.to_h
    end

    def set_initital_state(start)
      @state = '0'* @width
      @state[0] = '1' if start == :left
      @state[@width/2] = '1' if start == :middle
      @state[@width-1] = '1' if start == :right
    end

    def evolve
      new_state = '0'* @width
      (0..@width-1).each do |i|
        pattern = @state[i-1,3]
        if i == 0
           pattern = @state[-1]+@state[0,2]
        elsif i == (@width-1)
           pattern = @state[i-1,2]+@state[0]
        end
        new_state[i] = transition[pattern]
      end
      @state = new_state
    end
  end
end

# usage
# $ irb
# require './algorithms/automata.rb'
# automaton = Automata::ElementaryCA.new(rule: 30, width: 32, start: :middle)
# 16.times do puts automaton.state; automaton.evolve end

# automaton = Automata::ElementaryCA.new(rule: 110, width: 32, start: :right)
# 32.times do puts automaton.state; automaton.evolve end
