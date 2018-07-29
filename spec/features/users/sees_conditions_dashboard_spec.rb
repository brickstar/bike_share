require 'rails_helper'

=begin

As a registered user,
When I visit '/conditions-dashboard',
I see the Breakout of
average number of rides,
highest number of rides,
and lowest number of rides
on days with a high temperature
in 10 degree chunks (e.g. average number of rides on days with
high temps between fifty and sixty degrees)

44-102

7 total

range = (40..110)

range.step(10).map do |range|
  Condition.joins(:trips).where(max_temp: range)
  .group(:condition_id)
  .count(:condition_id)
end

Condition.maximum/minimum attribute .floor(-1) .ceil(-1)

until min >= max
 thing << [min, (min + 9.9)]
 min += 10
end

(min..max).step(10) do |n|
  ary << n
end

joins(:trips)
     .where(max_temp: range)
     .group(:condition_id)
     .count(:condition_id)
     .values

Condition.joins(:trips).where(max_temp: 50..60).group(:condition_id).count.values

Condition.select("conditions.max_temp, count(trips.id) as trip_count")
.joins("inner join trips on conditions.zip_code=trips.zip_code")
.where("conditions.date=trips.start_date")
.group(:max_temp,:id)

 ary.map { |range| Condition.where(max_temp: range[0]..range[1]).joins(:trips).group(:date, :max_temp).order(:max_temp).count(:condition_id).values.max}

Condition.joins("INNER JOIN trips ON conditions.date = trips.start_date")
.select("conditions.date, count(trips.id) as trip_count")
.where(max_temp: 40..50)
.group("conditions.date")
.order("trip_count DESC")
.first.trip_count

def thing
ary = [[40, 50], [50, 60], [60, 70], [70, 80], [80, 90], [90, 100], [100, 110]]
thing = ary.map do |array|
Condition.select("conditions.id, conditions.date").where("max_temp >= ? AND max_temp <= ?", array[0][0], array[0][1]).pluck(:date)
end
thing
end

ary = [[0, 0.5], [0.5, 1], [1.0, 70], [70, 80], [80, 90], [90, 100], [100, 110]]

Condition.joins(:trips).where("max_temp >= #{r[0]} AND max_temp <= #{r[1]}")
.group(:condition_id)
.count(:condition_id)
.values
=end

describe 'registered user visits /conditions-dashboard' do
  before(:each) do
    @user = User.create(first_name: 'Pearl', last_name: 'Girl', street: '333 E 9th Ave', city: 'Denver', state: 'CO', zip_code: '12345', email: 'pearl@pearl.com', password: 'lovelove', role: 1)
    @condition_1 = Condition.create(date: 'Tue, 04 Aug 2015', max_temp: 51, mean_temp: 68, min_temp: 61, mean_humidity: 61, mean_visibility:  1, mean_wind_speed: 1, precipitation: 0.1)
    @condition_2 = Condition.create(date: 'Wed, 05 Jan 2013', max_temp: 59, mean_temp: 58, min_temp: 46, mean_humidity: 50, mean_visibility: 3, mean_wind_speed: 3, precipitation: 0.4)
    @condition_3 = Condition.create(date: 'Wed, 06 Jan 2013', max_temp: 61, mean_temp: 58, min_temp: 46, mean_humidity: 50, mean_visibility: 5, mean_wind_speed: 5, precipitation: 0.6)
    @condition_4 = Condition.create(date: 'Wed, 07 Jan 2013', max_temp: 69, mean_temp: 58, min_temp: 46, mean_humidity: 50, mean_visibility: 8, mean_wind_speed: 8, precipitation: 0.9)
    @trip_1 = @condition_1.trips.create(duration: 120, start_date: DateTime.strptime('08/04/2015 12:12', '%m/%d/%Y %H:%M'), start_station_name: 'San Jose City Hall', start_station_id: 1, end_date: DateTime.strptime('08/04/2015 12:42', '%m/%d/%Y %H:%M'), end_station_name: 'San Jose City Hall', end_station_id: 1, bike_id: 1, subscription_type: 'subscriber', zip_code: '32174')
    @trip_2 = @condition_2.trips.create(duration: 120, start_date: DateTime.strptime('01/05/2013 12:12', '%m/%d/%Y %H:%M'), start_station_name: 'San Jose City Hall', start_station_id: 1, end_date: DateTime.strptime('01/05/2013 12:42', '%m/%d/%Y %H:%M'), end_station_name: 'San Jose City Hall', end_station_id: 1, bike_id: 1, subscription_type: 'subscriber', zip_code: '32174')
    @trip_3 = @condition_2.trips.create(duration: 120, start_date: DateTime.strptime('01/05/2013 12:12', '%m/%d/%Y %H:%M'), start_station_name: 'San Jose City Hall', start_station_id: 1, end_date: DateTime.strptime('01/05/2013 12:42', '%m/%d/%Y %H:%M'), end_station_name: 'San Jose City Hall', end_station_id: 1, bike_id: 1, subscription_type: 'subscriber', zip_code: '32174')
    @trip_4 = @condition_2.trips.create(duration: 120, start_date: DateTime.strptime('01/05/2013 12:12', '%m/%d/%Y %H:%M'), start_station_name: 'San Jose City Hall', start_station_id: 1, end_date: DateTime.strptime('01/05/2013 12:42', '%m/%d/%Y %H:%M'), end_station_name: 'San Jose City Hall', end_station_id: 1, bike_id: 1, subscription_type: 'subscriber', zip_code: '32174')
    @trip_5 = @condition_3.trips.create(duration: 120, start_date: DateTime.strptime('01/06/2013 12:12', '%m/%d/%Y %H:%M'), start_station_name: 'San Jose City Hall', start_station_id: 1, end_date: DateTime.strptime('01/06/2013 12:42', '%m/%d/%Y %H:%M'), end_station_name: 'San Jose City Hall', end_station_id: 1, bike_id: 1, subscription_type: 'subscriber', zip_code: '32174')
    @trip_6 = @condition_4.trips.create(duration: 120, start_date: DateTime.strptime('01/07/2013 12:12', '%m/%d/%Y %H:%M'), start_station_name: 'San Jose City Hall', start_station_id: 1, end_date: DateTime.strptime('01/07/2013 12:42', '%m/%d/%Y %H:%M'), end_station_name: 'San Jose City Hall', end_station_id: 1, bike_id: 1, subscription_type: 'subscriber', zip_code: '32174')
    @trip_7 = @condition_4.trips.create(duration: 120, start_date: DateTime.strptime('01/07/2013 12:12', '%m/%d/%Y %H:%M'), start_station_name: 'San Jose City Hall', start_station_id: 1, end_date: DateTime.strptime('01/07/2013 12:42', '%m/%d/%Y %H:%M'), end_station_name: 'San Jose City Hall', end_station_id: 1, bike_id: 1, subscription_type: 'subscriber', zip_code: '32174')
    @trip_8 = @condition_4.trips.create(duration: 120, start_date: DateTime.strptime('01/07/2013 12:12', '%m/%d/%Y %H:%M'), start_station_name: 'San Jose City Hall', start_station_id: 1, end_date: DateTime.strptime('01/07/2013 12:42', '%m/%d/%Y %H:%M'), end_station_name: 'San Jose City Hall', end_station_id: 1, bike_id: 1, subscription_type: 'subscriber', zip_code: '32174')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    visit conditions_dashboard_path
  end
  describe 'on days with high temperature in 10 degree chunks' do
    xit 'should see highest number of rides' do
      visit conditions_dashboard_path

      expect(page).to have_content('Highest rides by maximum temperature:')
      expect(page).to have_content('50-59.9: 3')
      expect(page).to have_content('60-69.9: 3')
    end
    xit 'should see lowest number of rides' do
      visit conditions_dashboard_path

      expect(page).to have_content('Lowest rides by maximum temperature:')
      expect(page).to have_content('50-59.9: 1')
      expect(page).to have_content('60-69.9: 1')
    end
    xit 'should see average number of rides' do
      visit conditions_dashboard_path

      expect(page).to have_content('Average rides by maximum temperature:')
      expect(page).to have_content('50-59.9: 2')
      expect(page).to have_content('60-69.9: 2')
    end
  end
end
=begin

I see the Breakout of
average number of rides,
highest number of rides,
and lowest number of rides
on days with precipitation in half-inch increments,

T-0-3.36

8 total
=end

=begin
I see the Breakout of
average number of rides,
highest number of rides, and
lowest number of rides
on days with mean wind speeds in four mile increments,

0-23

6 total
=end

=begin
I see the Breakout of
average number of rides,
highest number of rides, and
lowest number of rides
on days with mean visibility in miles in four mile increments.

4-20

5 total
=end
