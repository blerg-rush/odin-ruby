# frozen_string_literal: true

def stock_picker(prices)
  profits = profit_calculator(prices)
  day_to_buy = profits.index(profits.max)
  day_to_sell = prices.index(prices[day_to_buy..-1].max)

  [day_to_buy + 1, day_to_sell + 1]
end

def profit_calculator(prices)
  prices.map.with_index do |price, index|
    prices[index..-1].max - price
  end
end
