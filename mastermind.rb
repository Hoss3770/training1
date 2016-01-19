class Game
  attr_reader :allowed_colors,:length,:player,:secret_code,:tips

  def initialize(max_num_of_trys=12,allowed_colors={'r'=>'red','w'=>'white','b'=>'blue','g'=>'green','o'=>'orange'},guesser=true)
    @secret_code = nil
    @max_num_of_trys = max_num_of_trys # maxiumum num of trys
    @allowed_colors = allowed_colors # hash with allowed colors {r:red,w:white}
    @length = nil #the length of the secret code
    @player = Player.new(guesser,self) #
    @tips = []
    set_secret_code # the secret code set by user or computer
  end

  def set_secret_code()
    secret_code = @player.valid_input?
    if secret_code
      if secret_code.length > 4
        puts "are you sure you want your secret code to be more than 4 charachters(#{secret_code.length})[y/n]"
        response = gets.chomp.downcase
        if ["y","yes"].include?(response)
          @secret_code = secret_code
          @length = secret_code.length
        end
      else
        @secret_code = secret_code
        @length = secret_code.length
      end
    end
  end
  def check_board(input)
    result = ""
    input_clone = input.clone.split("")
    secret_code_clone = @secret_code.clone.split("")

    for i in (0..(secret_code_clone.size-1))
      if secret_code_clone[i] == input_clone[i]
        result << '!'
        secret_code_clone[i] = nil
        input_clone[i] = nil
      end
    end
    for i in (0..(input_clone.size-1))
      if !input_clone[i].nil? && secret_code_clone.include?(input_clone[i])
        result << '*'
      end
      for j in (0..(secret_code_clone.size-1))
        if (secret_code_clone[j] == input_clone[i])
          secret_code_clone[j] = nil
        end
      end
      input_clone[i] = ""
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
  def analyze
     next_try = ''
     rights = @game.tips[-1].count('!')
     right_letter = nil
     @game.allowed_colors.keys.each{|k| right_letter = k if @trys[-1].scan(/#{k}/) == rigths }
  end

  def play()
    if @guesser
      inp = valid_input?
      if inp
        @trys << inp
        @game.print_board(inp)
        return inp
      end

    else

    end
  end
  def valid_input?

    input = gets.downcase.chomp
    if  caller[0][/`.*'/][1..-2] == 'set_secret_code' #check if its is being set
      input = (0...4).map {@game.allowed_colors.keys[rand(@game.allowed_colors.length)]}.join('') if @guesser
     if (input.split('') - @game.allowed_colors.keys).empty?
       input
     end
    else
    if input.length == @game.length && (input.split('') - @game.allowed_colors.keys).empty?
        if !@guesser
          input
        end
        input
    else
      puts "input is invalid please put it in this format: rgbw #{@game.allowed_colors}and im must be of length #{@game.length}"
      false
    end
    end
  end
end


