class Game
  attr_reader :allowed_colors,:length,:player
  def initialize(max_num_of_trys=12,length=4,allowed_colors={'r'=>'red','w'=>'white','b'=>'blue','g'=>'green','o'=>'orange'},guesser=true)

    @max_num_of_trys = max_num_of_trys # maxiumum num of trys
    @allowed_colors = allowed_colors # hash with allowed colors {r:red,w:white}
    @length = length #the length of the secret code
    @player = Player.new(guesser,self) #
    @tips = []
    set_secret_code # the secret code set by user or computer
  end
  def set_secret_code()
      secret_code = @player.valid_input?
    if secret_code
     if secret_code.length > 4
      puts "are you sure you want your secret code to be more than 4 charachters(#{secret_code.length})[y/n]"
      response = gets
      if ["y","Y","yes",'Yes','YES'].include?(response)
        @secret_code = secret_code
        @length = secret_code.length
      end
     else
       @secret_code = secret_code
     end
    end
  end
  def check_board(input)
    result = ""
    input_clone = input.clone.split("")
    secret_code_clone = @secret_code.clone.split("")
    i = 0
    for e in input_clone
      if e == @secret_code[i]
        result << '!'
        input_clone[i] = nil
      end
      for el in secret_code_clone
        if e == el
          result << '*'
          input_clone[i] = nil
          secret_code_clone[i] = nil
        end
      end
      i =+ 1
    end
    @tips << result
  end
  def win?(input)
    input == @secret_code
  end
  def print_board(input)
   if !win?(input)
     check_board(input)
    @player.trys.each_with_index  do |try,index|
        puts "#{index+1}.| #{try.split("").join(" ")} |#{@tips[index]}" #splits the string into an array then joins it ands adds a space between
      end
    (@max_num_of_trys -  @player.trys.length).times{|n| puts "#{n+1}.| #{'_ ' * @length} |"}
   else
     puts "you got the code"
   end
  end

end
class Player
  attr_accessor :trys,:game

  def initialize(guesser,game)
    @guesser = guesser
    @trys = []
    @game = game
  end


  def play()
    inp = valid_input?
    if inp
      @trys << inp
      @game.print_board(inp)
      return inp
    end

  end
  def valid_input?
    input = gets.downcase.chomp
    if input.length == @game.length && (input.split('') - @game.allowed_colors.keys).empty?
      input
    else
      puts "input is invalid please put it in this format: rgbw #{@game.allowed_colors}"
      false
    end
  end
end
