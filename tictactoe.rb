# first you want to draw the board (we start with a 3x3 board), initalize it, two players (player gets X, computer gets O)
# then a loop of where the player goes, and the computer goes, until there are no empty spaces left.
# for each move, we are checking if there is 3 in a row, because then there would be a winner. if there is no winner, and there are no empty spaces left, then it is a tie.

# classes(nouns with attributes): 
# player, 
#    - name
#    - marker
# board, 
#   - all squares marked?
#   - find all empty squares
#   - squares
#   - 
# gameplay, 
# square,
#   - occupied?
#   - mark a square with a marker

require 'pry'

class Board
  WINNING_LINES = [[1,2,3],[4,5,6],[7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]]

  def initialize
    @data = {}
    (1..9).each {|position| @data[position] = Square.new(' ')}
  end

  def draw_board
    system 'clear'
    puts " #{@data[1]}|  #{@data[2]}| #{@data[3]}"
    puts "-----------"
    puts " #{@data[4]}|  #{@data[5]}| #{@data[6]}"
    puts "-----------"
    puts " #{@data[7]}|  #{@data[8]}| #{@data[9]}"
  end

  def all_squares_marked?
    empty_squares.size == 0
  end

  def empty_squares
    @data.select {|_, square| square.empty?}.values
  end

  def empty_positions
    @data.select {|_, square| square.empty? }.keys
  end

  def mark_square(position, marker)
    @data[position].mark(marker)
  end

  def winning_condition?(marker)
    WINNING_LINES.each do |line|
      return true if @data[line[0]].value == marker && @data[line[1]].value == marker && @data[line[2]].value == marker
    end
    false
  end

end

class Square
  attr_accessor :value

  def initialize(value)
    @value = value
  end

  def mark(marker)
    @value = marker
  end

  def empty?
    @value == ' '
  end

  def to_s
    @value
  end

end

class Player
  attr_reader :marker, :name

  def initialize(name, marker)
    @name = name
    @marker = marker
  end

end

class Game
  def initialize
    @board = Board.new
    @human = Player.new("Chris", "X")
    @computer = Player.new("Comp", "O")
    @current_player = @human
  end

  def current_player_marks_square
    if @current_player == @human
      begin
        puts "Choose a position (1-9):"
        position = gets.chomp.to_i
      end until @board.empty_positions.include?(position)
    else
      position = @board.empty_positions.sample
    end
    @board.mark_square(position, @current_player.marker)
  end

  def current_player_win?
    @board.winning_condition?(@current_player.marker)
  end

  def alternate_player
    if @current_player == @human
      @current_player = @computer
    else
      @current_player = @human
    end
  end

  def play
    @board.draw_board
    loop do
      current_player_marks_square
      @board.draw_board
      if current_player_win?
        puts "The Winner is #{@current_player.name}!"
        break
      elsif @board.all_squares_marked?
        puts "it's tie!"
        break
      else
        alternate_player
      end
    end
  end

end


Game.new.play