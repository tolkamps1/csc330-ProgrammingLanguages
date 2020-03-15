# Programming Languages, Homework 6, hw6runner.rb

# This is the only file you turn in,
# so do not modify the other files as
# part of your solution.

class MyPiece < Piece
  # The constant All_My_Pieces should be declared here:
  # class array holding all the pieces and their rotations
  All_My_Pieces = [[[[0, 0], [1, 0], [0, 1], [1, 1]]],  # square (only needs one)
               rotations([[0, 0], [-1, 0], [1, 0], [0, -1]]), # T
               [[[0, 0], [-1, 0], [1, 0], [2, 0]], # long (only needs two)
               [[0, 0], [0, -1], [0, 1], [0, 2]]],
               rotations([[0, 0], [0, -1], [0, 1], [1, 1]]), # L
               rotations([[0, 0], [0, -1], [0, 1], [-1, 1]]), # inverted L
               rotations([[0, 0], [-1, 0], [0, -1], [1, -1]]), # S
               rotations([[0, 0], [1, 0], [0, -1], [-1, -1]]), # Z
               [[[0, 0],[-1, 0], [-2, 0], [1, 0], [2, 0]], # extra long
               [[0, 0],[0, -1], [0, -2], [0, 1], [0, 2]]],
               rotations([[0, 0], [0, 1], [1, 1]]), # small L
               rotations([[0, 0], [-1, 0], [1, 0], [0, -1], [-1, -1]])] # T plus square
  @cheat_piece = [[0,0]]

  # Your Enhancements here
  def initialize(point_array, board)
    super
  end

  # class method to choose the next piece
  def self.next_piece (board)
    MyPiece.new(All_My_Pieces.sample, board)
  end

  # class method to choose cheat piece
  def self.cheat(board)
    MyPiece.new(@cheat_piece, board)
  end


end


class MyBoard < Board
  @cheat

  # Your Enhancements here:
  def initialize(game)
    super
    @current_block = MyPiece.next_piece(self)
    @cheat = false
  end

  # rotates the current piece 180 degrees
  def rotate_180
    if !game_over? and @game.is_running?
      @current_block.move(0, 0, 2)
    end
    draw
  end

  # gets the next piece
  def next_piece
    if @cheat
      @current_block = MyPiece.cheat(self)
      @score -= 100
      @cheat = false
    else
      @current_block = MyPiece.next_piece(self)
    end
    @current_pos = nil
  end

  # cheat piece if score >= 100
  def cheat
    if @score >= 100
      @cheat = true
    end
  end

  # gets the information from the current piece about where it is and uses this
  # to store the piece on the board itself. Then calls remove_filled.
  # modified to handle cases for pieces with not 4 squares.
  def store_current
    locations = @current_block.current_rotation
    displacement = @current_block.position
    (0..4).each{|index| 
      current = locations[index]
      if current
        @grid[current[1]+displacement[1]][current[0]+displacement[0]] = 
        @current_pos[index]
      end
    }
    remove_filled
    @delay = [@delay - 2, 80].max
  end



end


class MyTetris < Tetris
  # Your Enhancements here:
  def initialize
    super
  end

  # creates a canvas and the board that interacts with it
  def set_board
    @canvas = TetrisCanvas.new
    @board = MyBoard.new(self)
    @canvas.place(@board.block_size * @board.num_rows + 3,
                  @board.block_size * @board.num_columns + 6, 24, 80)
    @board.draw
  end

  # add key bindings
  def key_bindings
    super
    @root.bind('u', proc {@board.rotate_180})
    @root.bind('c', proc {@board.cheat})
  end


end



##########################
##########################
# My Challenge Code

class MyPieceChallenge < MyPiece
  @trim
  @trim_excess
  @cheat_piece = [[0,0]]

  # Your Enhancements here
  def initialize(point_array, board)
    super
    @trim = 0
    @trim_excess = []
  end

  # class method to choose the next piece
  def self.next_piece (board)
    MyPieceChallenge.new(All_My_Pieces.sample, board)
  end

  # method to choose cheat piece
  def self.cheat(board)
    MyPieceChallenge.new(@cheat_piece, board)
  end

  def trim
    @trim
  end

  # method to trim piece randomly by at most two blocks
  # starts re-adding blocks if two blocks has been trimmed
  def trim_all_rotations
    @trim += 1
    if @trim <= 2
      new_rotations = []
      excess = []
      block = rand(@all_rotations.size)
      (0..((@all_rotations.size) -1)).each{|index| 
        current = Marshal.load(Marshal.dump(@all_rotations[index]))
        excess.push current.delete_at(block)
        new_rotations.push current
      }
      @all_rotations = new_rotations
      @trim_excess.push excess
    else
      add_rotations
    end
    if @trim >= 4
      @trim = 0
    end
  end

  # add pieces back
  def add_rotations
    new_rotations = []
    (0..((@all_rotations.size) -1)).each{|index| 
      current = Marshal.load(Marshal.dump(@all_rotations[index]))
      current.push @trim_excess[(@trim_excess.size)-1].shift
      new_rotations.push current
    }
    @all_rotations = new_rotations
    @trim_excess.pop
  end

end


class MyBoardChallenge < MyBoard
  # Your Enhancements here:
  def initialize(game)
    super
    @current_block = MyPieceChallenge.next_piece(self)
  end

  # trim piece 
  def trim
    # if cheat piece
    if @current_block.current_rotation.size <= 1
      return
    elsif @current_block.trim >= 2
      @score += 20
      @current_block.trim_all_rotations
    elsif @score >= 40
      @score -= 40
      @current_block.trim_all_rotations
    end
  end

  # gets the next piece
  def next_piece
    if @cheat
      @current_block = MyPieceChallenge.cheat(self)
      @score -= 100
      @cheat = false
    else
      @current_block = MyPieceChallenge.next_piece(self)
    end
    @current_pos = nil
  end

end


class MyTetrisChallenge < MyTetris
  # Your Enhancements here:

  # creates a canvas and the board that interacts with it
  def set_board
    @canvas = TetrisCanvas.new
    @board = MyBoardChallenge.new(self)
    @canvas.place(@board.block_size * @board.num_rows + 3,
                  @board.block_size * @board.num_columns + 6, 24, 80)
    @board.draw
  end

  # add key bindings
  def key_bindings
    super
    @root.bind('t', proc {@board.trim})
  end


end


