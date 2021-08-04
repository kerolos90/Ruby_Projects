def bubble_sort(arr)
    holder = 0
    (0..arr.length).each do
        arr.each_with_index do |num, index|
            if arr[index+1] != nil && arr[index+1] < num
                holder = num
                arr[index] = arr[index+1]
                arr[index+1] = holder
            end
        end
    end
    arr
end
print bubble_sort([4,3,78,2,0,2])