require 'csv'

ActiveRecord::Base.connection.reset_pk_sequence!('stations')
ActiveRecord::Base.connection.reset_pk_sequence!('trips')
ActiveRecord::Base.connection.reset_pk_sequence!('conditions')

CSV.foreach('./../sf-bay-area-bike-share/weather.csv', headers: true, header_converters: :symbol).with_index do |row, index|
  formatted_date = Date.strptime row[0], '%m/%d/%Y'
  Condition.create(date:formatted_date, max_temp:row[1], mean_temp:row[2], min_temp:row[3], mean_humidity:row[8], mean_visibility:row[14], mean_wind_speed:row[17], precipitation:row[19], zip_code:row[23])
end

CSV.foreach('./../sf-bay-area-bike-share/trip.csv', headers: true, header_converters: :symbol).with_index do |row, index|
  if index%149 == 0
    next if index.zero?
    next unless row[:zip_code]
    next if row[:zip_code].length != 5
    formatted_start_date = Date.strptime row[2], '%m/%d/%Y'
    formatted_end_date = Date.strptime row[2], '%m/%d/%Y'
    condition = Condition.find_by(date: formatted_start_date)
    Trip.create(id: row[0],
                duration: row[1],
                start_date: formatted_start_date,
                start_station_name: row[3],
                start_station_id: row[4],
                end_date: formatted_end_date,
                end_station_name: row[6],
                end_station_id: row[7],
                bike_id: row[8],
                subscription_type: row[9],
                condition_id: condition.try(:id),
                zip_code: row[10])
  end
end

CSV.foreach('./../sf-bay-area-bike-share/station.csv', headers: true, header_converters: :symbol) do |row|
  formatted_date = Date.strptime row[6], '%m/%d/%Y'
  Station.create(id: row[0], name:row[1], dock_count:row[4], city:row[5], installation_date:formatted_date)
end


IMAGES = []
100.times do
  IMAGES << "https://robohash.org/#{rand(1000)}"
end

User.create(first_name: 'admin', last_name: 'Girl', street: '9th Ave', city: 'Denver', state: 'CO', zip_code: '12345', email: 'admin', password: 'adminadmin', role: 1)
User.create(first_name: 'user', last_name: 'Boy', street: '9th Ave', city: 'Denver', state: 'CO', zip_code: '12345', email: 'user', password: 'useruser', role: 0)

Accessory.create(image_url: IMAGES.sample, title: 'Robo-Bob', description: 'I am robotic.', price: 1)
Accessory.create(image_url: IMAGES.sample, title: 'Robo-Hank', description: 'I am robotic.', price: 2)
Accessory.create(image_url: IMAGES.sample, title: 'Robo-Tom', description: 'I am robotic.', price: 3)
Accessory.create(image_url: IMAGES.sample, title: 'Robo-Bill', description: 'I am robotic.', price: 4)
Accessory.create(image_url: IMAGES.sample, title: 'Robo-Troy', description: 'I am robotic.', price: 5, status: 0)
Accessory.create(image_url: IMAGES.sample, title: 'Robo-George', description: 'I am robotic.', price: 5, status: 0)
Accessory.create(image_url: IMAGES.sample, title: 'Robo-Larry', description: 'I am robotic.', price: 6)
Accessory.create(image_url: IMAGES.sample, title: 'Robo-Carl', description: 'I am robotic.', price: 7)
Accessory.create(image_url: IMAGES.sample, title: 'Robo-Todd', description: 'I am robotic.', price: 8)
Accessory.create(image_url: IMAGES.sample, title: 'Robo-Chad', description: 'I am robotic.', price: 9)
Accessory.create(image_url: IMAGES.sample, title: 'Robo-Randy', description: 'I am robotic.', price: 10)
Accessory.create(image_url: IMAGES.sample, title: 'Robo-Steve', description: 'I am robotic.', price: 11)
Accessory.create(image_url: IMAGES.sample, title: 'Robo-Roy', description: 'I am robotic.', price: 12)

Order.create(user_id: 1, status: 'paid')
Order.create(user_id: 1, status: 'cancelled')
Order.create(user_id: 1, status: 'paid')
Order.create(user_id: 1, status: 'ordered')
Order.create(user_id: 1, status: 'paid')
Order.create(user_id: 1, status: 'ordered')
Order.create(user_id: 2, status: 'paid')
Order.create(user_id: 2, status: 'cancelled')
Order.create(user_id: 2, status: 'paid')
Order.create(user_id: 2, status: 'paid')
Order.create(user_id: 2, status: 'completed')
Order.create(user_id: 2, status: 'completed')
Order.create(user_id: 2, status: 'completed')

OrderAccessory.create(order_id: 1, accessory_id: 1, quantity: 5)
OrderAccessory.create(order_id: 2, accessory_id: 2, quantity: 4)
OrderAccessory.create(order_id: 3, accessory_id: 3, quantity: 3)
OrderAccessory.create(order_id: 4, accessory_id: 4, quantity: 5)
OrderAccessory.create(order_id: 7, accessory_id: 7, quantity: 2)
OrderAccessory.create(order_id: 8, accessory_id: 8, quantity: 1)
OrderAccessory.create(order_id: 9, accessory_id: 9, quantity: 2)
OrderAccessory.create(order_id: 10, accessory_id: 10, quantity: 5)
OrderAccessory.create(order_id: 11, accessory_id: 11, quantity: 3)
OrderAccessory.create(order_id: 12, accessory_id: 12, quantity: 1)
OrderAccessory.create(order_id: 13, accessory_id: 13, quantity: 4)


puts Trip.count puts 'trips'
puts Station.count puts 'stations'
puts Condition.count puts 'conditions'
puts Accessory.count puts 'accessories'
puts User.count puts 'users'
