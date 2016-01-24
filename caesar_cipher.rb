class String
  def prev
    str = ((self.ord)-1).chr
    str = "Z" if str == "@"
    str = "z" if str == "\`"
    return str
  end
end
def caesar_cipher(string,int,enc=:next)
  chars = string.chars
 int.times do
   chars.collect! do |char|
     if (("a".."z") === char) || (("A".."Z") === char)
         char.send(enc)[0]
      else char
     end
  end
 end
  puts chars.join
  chars.join
end
x =
puts x == "Bmfy f xywnsl!"
caesar_cipher(caesar_cipher('What a string!', 5),5,:prev)
puts (("abc".ord)).chr