class Point
  attr_accessor :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def self.new_from_key(key)
    x,y = key.split('-').map(&:to_i)
    obj = new(x, y)
  end

  def key
    "#{x}-#{y}"
  end
end

class Grid
  attr_accessor :w, :h, :nodes

  def initialize(w, h)
    @w = w
    @h = h
    @nodes = Array.new(w) { Array.new(h, 0) }
  end

  def self.new_from_array(nodes)
    w = nodes.first.length
    h = nodes.length
    obj = new(w, h)
    obj.nodes = nodes.clone
    obj
  end

  def to_array
    nodes
  end

  def mark_points(points, mark = '.')
    points.each do |key|
      point = Point.new_from_key(key)
      self[point.y][point.x] = mark
    end
  end

  def width
    @w
  end

  def height
    @h
  end

  def [](row)
    @nodes[row]
  end

  def print
    @nodes.each do |row|
      puts row.join
    end
  end

  # heuristic
  def self.cityblock_distance(a, b)
    (a.x-b.x).abs + (a.y-b.y).abs
  end

  def self.euclidean_distance(a, b)
    Math.sqrt((a.x-b.x)**2 + (a.y-b.y)**2)
  end

  def neighbors4(p)
    Grid.neighbors4(p, @w, @h)
  end

  def self.neighbors4(p, w, h)
    x, y = p.x, p.y
    result = []
    result << Point.new(x-1,y  ) if x > 0
    result << Point.new(x  ,y-1) if y > 0
    result << Point.new(x+1,y  ) if x < (w-1)
    result << Point.new(x  ,y+1) if y < (h-1)
    result
  end

  def neighbors8(p)
    Grid.neighbors8(p, @w, @h)
  end

  def self.neighbors8(p, w, h)
    x, y = p.x, p.y
    result = []
    result << Point.new(x-1,y  ) if (x > 0)
    result << Point.new(x-1,y-1) if (x > 0) && (y > 0)
    result << Point.new(x  ,y-1) if (y > 0)
    result << Point.new(x+1,y-1) if (x < (w-1)) && (y > 0)
    result << Point.new(x+1,y  ) if (x < (w-1))
    result << Point.new(x+1,y+1) if (x < (w-1)) && (y < (h-1))
    result << Point.new(x  ,y+1) if (y < (h-1))
    result << Point.new(x-1,y+1) if (x > 0) && (y < (h-1))
    result
  end
end
