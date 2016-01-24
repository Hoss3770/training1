dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
def substrings(str, dictionary)
 all_words = []
 hash = {}
 dictionary.each do |wo|
   all_words << str.downcase.scan(eval("/#{wo}/"))
 end
 all_words.each{ |a| hash[a[0]] = a.length if !a.empty?  }
 p hash == {"down"=>1, "how"=>2, "howdy"=>1,"go"=>1, "going"=>1, "it"=>2, "i"=> 3, "own"=>1,"part"=>1,"partner"=>1,"sit"=>1}
end
substrings("Howdy partner, sit down! How's it going?", dictionary)