module Enumerable
  def my_each
    for el in self
      yield(el)
      el
    end
  end

  def my_each_with_index
    i = 0
    for el in self
      yield(el,i)
      i+=1
    end
  end

  def my_select(&block)
    arr = []
    self.my_each{|el| arr << el if block.call(el) }
    arr
  end
  def my_all?(&block)

    arr = self.my_select(block)
    if arr.length == self.length
      true
    else
      false
    end
   end
  def my_none?(&block)
      !self.my_all?(&block)
  end

  def my_any?(&block)
    self.my_each do |el|
      if block.call(el)
      return true
      end
    end
    false
  end
  def my_count
    self.length
  end
  def my_map(&block)
    arr =[]
    self.my_each{|el| arr << block.call(el)}
    arr
  end
  def my_inject(&block,*sym)
    sum = 0
     self.my_each do |el|
       sum = block.call(sum,el)
     end
    sum
  end
end

a = Proc.new {|l|l>2}
p [1,2,3,4,4,5].my_select{|el| el > 3}
p [1,4,4,5].my_inject(:+)

