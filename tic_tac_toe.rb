class Game

  def initialize
    @game = {1=>nil,2=>nil,3=>nil,4=>nil,5=>nil,6=>nil,7=>nil,8=>nil,9=>nil}
    @x = []
    @y = []
  end
  def game
    @game
  end
  def print_game
    puts %Q(    #{game[1]}|#{game[2]}|#{game[3]}
    _______
    #{game[4]}|#{game[5]}|#{game[6]}
    _______
    #{game[7]}|#{game[8]}|#{game[9]}
   )
  end
  def x_play(num)

     if (1..9).to_a.include?(num)

      if @game[num] == nil
        @x << num
        @game[num] = "X"
      end
      print_game
      if winner?
        puts "#{winner?} won"
        @game.clear
        @x.clear
        @y.clear
      end
    else
     puts "Sorry number not within range 1 to 9"
    end
  end

  def y_play(num)
    if (1..9).to_a.include?(num)

      if @game[num] == nil
        @y << num
        @game[num] = "Y"
      end
      print_game
      if winner?
        puts "#{winner?} won"
        @game.clear
        @x.clear
        @y.clear
      end
    else
      puts "Sorry number not within range 1 to 9"
    end
  end
  def winner?

    wins = [[1,2,3],[1,4,7],[1,5,9],[3,5,7],[2,5,8],[4,5,6],[7,8,9]]
    winner = nil
    wins.each do |arr|
      if (arr - @x).empty?
        winner ||= 'X'
        break
      end
    end
    wins.each do |arr|
      if (arr - @y).empty?
        winner =  'Y'
        break
      end
    end
    winner
    end

end

