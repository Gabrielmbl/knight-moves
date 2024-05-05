class Space
  attr_accessor :x, :y, :children, :parent
  def initialize(x, y, parent = nil)
    @x = x
    @y = y
    @children = []
    @parent = parent
  end
end

def create_children(board)
  potential_moves = []
  potential_moves.push(
    [board.x + 1, board.y + 2],
    [board.x + 1, board.y - 2],
    [board.x - 1, board.y + 2],
    [board.x - 1, board.y - 2],
    [board.x + 2, board.y + 1],
    [board.x + 2, board.y - 1],
    [board.x - 2, board.y + 1],
    [board.x - 2, board.y - 1]
  )

  valid_children = potential_moves.select do |space|
    space[0].between?(0,8) && space[1].between?(0,8)
  end

  valid_children = valid_children.map do |space|
    Space.new(space[0], space[1], board)
  end

  @children = valid_children
end

def knight_moves(first_space, final_space)
  first_children = Space.new(first_space[0], first_space[1])
  create_children(first_children)
  bread_first_search(final_space, @children)
end

def bread_first_search(search_space, children)
  queue = children

  while !queue.empty?
    current= queue.shift
    if [current.x, current.y] == search_space
      display_path(current)
      return
    else
      create_children(current).each { |child| queue << child }
    end
  end
end

def display_path(current)
  path = []
  while current
    path.unshift([current.x, current.y])
    current = current.parent
  end
  num_moves = path.length - 1
  puts "You made it in #{num_moves} moves! Here's your path:"
  path.each { |coord| p coord }
end