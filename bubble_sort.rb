def bubble_sort(arr)
  loop do
    x, i = 0, 0
    while i < arr.length - 1 do
      if arr[i+1] < arr[i]
        arr[i], arr[i+1] = arr[i+1], arr[i]
        x += 1
      end
      i += 1
    end
    break if x == 0
  end
  return arr
end
p bubble_sort([10,9,0,1,4,13,134341344324,-4])

def bubble_sort_by(arr,&block)

  loop do
    x, i = 0, 0
    while i < arr.length - 1 do
      if block.call(arr[i],arr[i+1]) > 0
        arr[i], arr[i+1] = arr[i+1], arr[i]
        x += 1
      end
      i += 1
    end
    break if x == 0
  end
  return arr
end
p bubble_sort_by(["hi","hello","hindiss","h"]){ |left,right|
   left.length
}

x = Proc.new{puts "a"}
x.call