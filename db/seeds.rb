require 'csv'

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
    # if condition
    #   condition_id = condition.id
    # else
    #   condition_id = nil
    # end
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


puts Trip.count
puts Station.count
puts Condition.count
