require 'csv'

Trip.destroy_all
Station.destroy_all
Condition.destroy_all

CSV.foreach('./../sf-bay-area-bike-share/trip.csv', headers: true, header_converters: :symbol).with_index do |row, index|
  if index%149 == 0
    next if index.zero?
    next unless row[:zip_code]
    next if row[:zip_code].length != 5
    formatted_start_date = DateTime.strptime row[2], '%m/%d/%Y %H:%M'
    formatted_end_date = DateTime.strptime row[2], '%m/%d/%Y %H:%M'
    Trip.create(id:row[0], duration:row[1], start_date:formatted_start_date, start_station_name:row[3], start_station_id:row[4], end_date:formatted_end_date, end_station_name:row[6], end_station_id:row[7], bike_id:row[8], subscription_type:row[9], zip_code:row[10])
  end
end

CSV.foreach('./../sf-bay-area-bike-share/station.csv', headers: true, header_converters: :symbol) do |row|
  formatted_date = Date.strptime row[6], '%m/%d/%Y'
  Station.create(id: row[0], name:row[1], dock_count:row[4], city:row[5], installation_date:formatted_date)
end

CSV.foreach('./../sf-bay-area-bike-share/weather.csv', headers: true, header_converters: :symbol).with_index do |row, index|
  formatted_date = Date.strptime row[0], '%m/%d/%Y'
  Condition.create(date:formatted_date, max_temp:row[1], mean_temp:row[2], min_temp:row[3], mean_humidity:row[8], mean_visibility:row[14], mean_wind_speed:row[17], precipitation:row[19])
end

Accessory.create(image_url: 'www.insertrealpics.com', title: 'test1', description: 'this is a test', price: 1)
Accessory.create(image_url: 'www.insertrealpics.com', title: 'test2', description: 'this is a test', price: 2)
Accessory.create(image_url: 'www.insertrealpics.com', title: 'test3', description: 'this is a test', price: 3)
Accessory.create(image_url: 'www.insertrealpics.com', title: 'test4', description: 'this is a test', price: 4)
Accessory.create(image_url: 'www.insertrealpics.com', title: 'test5', description: 'this is a test', price: 5, status: 0)
Accessory.create(image_url: 'www.insertrealpics.com', title: 'test5', description: 'this is a test', price: 5, status: 0)
Accessory.create(image_url: 'www.insertrealpics.com', title: 'test6', description: 'this is a test', price: 6)
Accessory.create(image_url: 'www.insertrealpics.com', title: 'test7', description: 'this is a test', price: 7)
Accessory.create(image_url: 'www.insertrealpics.com', title: 'test8', description: 'this is a test', price: 8)
Accessory.create(image_url: 'www.insertrealpics.com', title: 'test9', description: 'this is a test', price: 9)
Accessory.create(image_url: 'www.insertrealpics.com', title: 'test10', description: 'this is a test', price: 10)
Accessory.create(image_url: 'www.insertrealpics.com', title: 'test11', description: 'this is a test', price: 11)
Accessory.create(image_url: 'www.insertrealpics.com', title: 'test12', description: 'this is a test', price: 12)

User.create(first_name: 'admin', last_name: 'girl', street: '9th ave', city: 'denver', state: 'CO', zip_code: '12345', email: 'admin', password: 'adminadmin', role: 1)
User.create(first_name: 'user', last_name: 'girl', street: '9th ave', city: 'denver', state: 'CO', zip_code: '12345', email: 'user', password: 'useruser', role: 0)

puts Trip.count
puts Station.count
puts Condition.count
