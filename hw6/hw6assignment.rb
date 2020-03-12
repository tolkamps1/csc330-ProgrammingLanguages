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

  # Your Enhancements here
  def initialize(point_array, board)
    super
    @cheat_piece = [0, 0]
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
  # Your Enhancements here:
  def initialize(game)
    super
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
    @current_block = MyPiece.next_piece(self)
    @current_pos = nil
  end

  # cheat piece if score >= 100
  def cheat
    if @score >= 100
      #@current_block = MyPiece.cheat(self)
      #@current_pos = nil
      @score -= 100
    end
  end

end


class MyTetris < Tetris
  # Your Enhancements here:
  def initialize
    super
  end

  # creates a canvas and the board that interacts with it
  def set_board
    super
    @board = MyBoard.new(self)
  end

  # add key bindings
  def key_bindings
    super
    @root.bind('u', proc {@board.rotate_180})
    @root.bind('c', proc {@board.cheat})
  end


end


