def stock_picker(arrOfPrices)
  # cycle through each element
  pick = Array.new(3, 0)
  gain = 0
  arrOfPrices.each_with_index do |price, index|
    lastDay = (arrOfPrices.length - 1)
    # p [price, index, lastDay]
    Range.new(index, lastDay).each do |day|
      # p [index, day]
      # compute diff of upcoming prices
      # from current index to last index (length - 1 )
      profitLoss = arrOfPrices[day] - price
      # puts profitLoss
      # if larger diff save pair of days
      if profitLoss > gain
        gain = profitLoss
        pick = [index, day]
      end
    end
  end
  p pick
end

stock_picker([17, 3, 6, 9, 15, 8, 6, 1, 25])
