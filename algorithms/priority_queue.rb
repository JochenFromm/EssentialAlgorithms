class PriorityQueue
  def initialize(opts = {})
    @queue = []
  end

  def empty?
    @queue.empty?
  end

  def pop
    @queue.pop
  end

  alias_method :get, :pop

  def push(object, priority)
    @queue << [object, priority]
    @queue.sort!{ |x,y| x[1] <=> y[1]}
  end

  alias_method :put, :push

  def elements
    @queue
  end
end
