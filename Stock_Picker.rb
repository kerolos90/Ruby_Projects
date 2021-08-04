def stock_picker(arr)
    best_days = [0,0]
    arr.each_with_index do |buy, buy_index|
        arr.each_with_index do |sell, sell_index|
            if sell != nil && sell_index >= buy_index
               if (sell - buy)  > (arr[best_days[1]] -  arr[best_days[0]])
                    best_days[0]= buy_index
                    best_days[1]= sell_index
               end
            end
        end
    end
    p best_days
end
stock_picker([17,3,6,9,15,8,6,1,10])
