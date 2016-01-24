class Game

  def initialize
    @game = {1=>nil,2=>nil,3=>nil,4=>nil,5=>nil,6=>nil,7=>nil,8=>nil,9=>nil}
    @x = []
    @y = []
    @last_played = nil
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
    play("x",num)
  end
  def y_play(num)
      play("y",num)
  end
  def finshed?
     if @game.values.all?{|val| val == nil}
       self.instance_variables.each{|var| var = [] }
     end
  end
  def winner?
    wins = [[1,2,3],[1,4,7],[1,5,9],[3,5,7],[2,5,8],[4,5,6],[7,8,9]]
    winner = nil
    ['x','y'].each do |player|
      wins.each do |arr|
        if (arr - eval("@#{player}")).empty?
          winner ||= player.upcase
          break
        end
      end
    end
    winner
  end
private
  def play(pl,num)
    if (1..9).to_a.include?(num)
      if @last_played == pl
        puts "#{pl} already played"
      else
       if @game[num] == nil
          eval("@#{pl}") << num
          @game[num] = pl.upcase
          @last_played = pl
       end
      print_game
      end

  end
end

  end


