require 'byebug'
class Game

  attr_reader :allowed_colors,:length,:player,:secret_code,:tips

  def initialize(max_num_of_trys=12,allowed_colors={'r'=>'red','w'=>'white','b'=>'blue','g'=>'green','o'=>'orange'},guesser=1)
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
  def check_board(input,secret_code=nil,add_tip = true)
    result = ""
    input_clone = input.clone.split("")
    secret_code = secret_code.split('') if !secret_code.nil?
    secret_code = @secret_code.clone.split("") if secret_code.nil?

    for i in (0..(secret_code.size-1))
      if secret_code[i] == input_clone[i]
        result << '!'
        secret_code[i] = nil
        input_clone[i] = nil
      end
    end
    for i in (0..(input_clone.size-1))
      if !input_clone[i].nil? && secret_code.include?(input_clone[i])
        result << '*'
      end
      for j in (0..(secret_code.size-1))
        if (secret_code[j] == input_clone[i])
          secret_code[j] = nil
        end
      end
      input_clone[i] = ""
    end
     @tips << result if add_tip
     result
    end
  def all_possb
    all = []
    #create nested loops depdnding on the length to get all possbilties
    nested_loops = %Q{for i0 in @allowed_colors.keys
                        place
                      end}
    (@length - 1 ).times do|n|
      nested_loops.gsub!('place', %Q(for i#{ n+1 } in @allowed_colors.keys
                        place
                      end))

    end
    code = ''
    @length.times{|n|code<<"\#{i#{n}}"}
    nested_loops.gsub!('place',%Q(code =  "#{code}"
                        all << code))
    eval(nested_loops)
   return all
  end

  def win?()
    @player.trys.last == @secret_code
  end
  def print_board(input)
    if !win?()
      check_board(input)
      @player.trys.each_with_index  do |try,index|
        puts "#{index+1}.| #{try.split("").join(" ")} |#{@tips[index]}" #splits the string into an array then joins it ands adds a space between
      end
      (@max_num_of_trys -  @player.trys.length).times{|n| puts " #{n + @player.trys.length + 1 }.| #{'_ ' * @length} |"}
      puts"You have #{@max_num_of_trys - @tips.length} left"
    else
      puts "you got the code #{@secret_code} in #{@player.trys.size} guesses"
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

    all_codes = @game.all_possb
    computer_guess = 'r'* (@game.length/2) + 'g' * (@game.length/2)
    all_codes.delete(computer_guess)
    until @game.win?()

      play_pc(computer_guess)
      all_codes.delete_if do |code|
        #first compares the first guess to all and deltes all of them that do not get the same result ex(correct:1,almost2)
        #when it compares it to the answer
          #it compares itself to the answer and get the result ex.(correct:2,almost:1)
          #the it compares the answer to itself as if it is the answer and get the same thing ex.(correct:2,almost:1)
          #the compares both result to each other and of course the answer is not deleted
        #then it pick randomly the first element in the new array and starts again
        #....
        result = @game.check_board(code,computer_guess,false) #preventing the result to be added to @tips twice
        if (result.scan('!').size != @game.tips.last.scan('!').size || result.scan('*').size != @game.tips.last.scan('*').size )
          #delte
          true
        else
          false
        end

      end
      computer_guess = all_codes.first
    end
  end


  def play()

        inp = valid_input?
      if inp
        @trys << inp
        @game.print_board(inp)

        return inp
      end

  end
  def play_pc(inp)
    if inp
      @trys << inp
      @game.print_board(inp)
      sleep(2)
      return inp
    end
  end
  def valid_input?

    input = gets.downcase.chomp
    if  caller[0][/`.*'/][1..-2] == 'set_secret_code' #check if its is being set
      input = (0...4).map {@game.allowed_colors.keys[rand(@game.allowed_colors.length)]}.join('') if @guesser == 1
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

