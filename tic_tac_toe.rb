require 'matrix'

class TicTacToe

  def initialize()
    @inputsArr = []
    @inputsHash = {}
    @currentArr = Array.new(3) { Array.new(3," ") }
  end

  #starts the game and returns the winner
  def play
    reply = startMessage()
    if reply == "y"
      puts
      puts "Let's begin! Please enter the number of the cell where you want to place your X:"
      puts "(For example, type '1' for the top-left cell, '5' for the center cell, etc.)"
      puts
    else
      return
    end
    i = 0
    while true || i <= 3
      win = game()
      i += 1
      if win == "computer" || win == "player"
        puts "AND the Winner issss #{win}"
        break
      elsif i >= 4
        puts "OOPS seems like we don't have a winner"
        break
      end
    end
  end

  private


  WINNING_PATTERNS = [
    [1, 2, 3], # Horizontal pattern - 1st row
    [4, 5, 6], # Horizontal pattern - 2nd row
    [7, 8, 9], # Horizontal pattern - 3rd row
    [1, 4, 7], # Vertical pattern - 1st column
    [2, 5, 8], # Vertical pattern - 2nd column
    [3, 6, 9], # Vertical pattern - 3rd column
    [1, 5, 9], # Diagonal pattern - top-left to bottom-right
    [3, 5, 7]  # Diagonal pattern - top-right to bottom-left
  ]

  #playing
  def game
    h = "X"
    c = "O"
    numtoXOconverter(human(),h,numberedBoard())
    numtoXOconverter(cpu(),c,numberedBoard())
    printTheBoard(@currentArr)
    findsTheWinner(WINNING_PATTERNS)
  end




  # 1-9 numbered board
  def numberedBoard()
    x = 0
    nestedArr = Array.new(3) { Array.new(3) }
    numberedBoard = nestedArr.each_with_index do |row, row_index|
      row.each_with_index do |teacher, column_index|
        x = x + 1
        nestedArr[row_index][column_index] = x
      end
    end
  end


  # prints the board
  def printTheBoard(boardElements)
    puts "_#{boardElements[0][0]}_|_#{boardElements[0][1]}_|_#{boardElements[0][2]}_"
    puts "_#{boardElements[1][0]}_|_#{boardElements[1][1]}_|_#{boardElements[1][2]}_"
    puts "_#{boardElements[2][0]}_|_#{boardElements[2][1]}_|_#{boardElements[2][2]}_"

  end

  def numtoXOconverter(input,player,arr)
    index = Matrix[*arr].index(input) #finds the index of the nested array elements
    @currentArr[index[0].to_i][index[1].to_i] = player
    @inputsHash[input] = player
  end


  def cpu
    while true
    cpuInput = Random.rand(1..9)
      if @inputsArr.include?(cpuInput)

      else
        break
      end
    end
    @inputsArr.push(cpuInput)
    cpuInput

  end

  def human
    while true
      usrInput = gets.to_i
      if @inputsArr.include?(usrInput) || !usrInput.between?(1,9)
        puts("Try another number")
      else
        break
      end
    end
    @inputsArr.push(usrInput)
    usrInput
  end

  def findsTheWinner(winning_patterns)
      winner = ""
      for pattern in winning_patterns
        computer = 0
        player = 0
        for i in pattern
          if @inputsHash[i.to_i] == "X"
            player += 1
          elsif @inputsHash[i.to_i] == "O"
            computer += 1
          end
        end
        if player == 3
          winner = "player"
          break
        elsif computer == 3
          winner = "computer"
          break
        end
      end
      return winner
    end


  def startMessage()
    puts "How to Play:"
    puts
    puts "1.The 3x3 grid is numbered from 1 to 9, representing the positions where you can place your symbol."
    printTheBoard(numberedBoard())
    puts
    puts "2. To make a move, follow these steps:"
    puts
    puts "a. On your turn, enter the number of the cell where you want to place your symbol (X or O)."
    puts "b. Ensure the number you choose corresponds to an empty cell (one that has not been occupied by a previous move)."
    puts "c. The game will show the updated board after each move."
    puts
    puts "3.The game will continue alternating between players until one player wins or the game ends in a draw."
    puts
    puts "Let's start playing Tic-Tac-Toe now. As a reminder, you are X, and I am the computer player (O)."
    puts
    puts "The game board is numbered from 1 to 9, and you'll make the first move as X."
    puts "To make your move, simply enter the number of the cell where you want to place your X (1 to 9)."
    puts "Then, I'll make my move as O, and we'll continue taking turns until the game is over."
    puts "I'll display the updated board after each move."
    puts
    puts "lets start? (Enter Y/N)"
    reply = gets.chomp.downcase
  end

end

game = TicTacToe.new
game.play
