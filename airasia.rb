require 'rest-client'
require 'json'

min_price = nil
best_deal = {}

from = "DMK"
to = "NRT"
year = 2019
months = (1..12)

p "Checking outgoing flights..."

months.each do |month|
  p "Reading month #{month}..."
  url = "https://k.apiairasia.com/availabledates/api/v1/pricecalendar/1/0/THB/#{from}/#{to}/#{year}-#{sprintf('%02d', month)}-01/1"

  resp = RestClient.get(url)
  data = JSON.parse(resp)

  data.each do |_key, prices|
    prices.each do |date, price|
      if min_price.nil? || price < min_price
        min_price = price
        best_deal['date'] = date
        best_deal['price'] = price
      end
    end
  end

  p best_deal
end

p "Checking incoming flights..."

months.each do |month|
  p "Reading month #{month}..."
  url = "https://k.apiairasia.com/availabledates/api/v1/pricecalendar/1/0/THB/#{to}/#{from}/#{year}-#{sprintf('%02d', month)}-01/1"

  resp = RestClient.get(url)
  data = JSON.parse(resp)

  data.each do |_key, prices|
    prices.each do |date, price|
      if min_price.nil? || price < min_price
        min_price = price
        best_deal['date'] = date
        best_deal['price'] = price
      end
    end
  end

  p best_deal
end

