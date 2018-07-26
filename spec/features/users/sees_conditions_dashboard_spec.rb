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
high temps between fifty and sixty degrees

44-102

60-70 382
283
7 total

joins(:trips)
     .where(max_temp: range)
     .group(:condition_id)
     .count(:condition_id)
     .values

Condition.select("conditions.max_temp, count(trips.id) as trip_count")
.joins("inner join trips on conditions.zip_code=trips.zip_code")
.where("conditions.date=trips.start_date")
.group(:max_temp,:id)


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

trip[:condition_id] = if Condition.find_by(date: Date.strptime(trip[:end_date], '%m/%d/%Y'), zipcode: trip[:zip_code]).nil?
                        nil
                        next if trip[:zip_code]
                      else
                      if
                        Condition.find_by(date: Date.strptime(trip[:end_date], '%m/%d/%Y'), zipcode: trip[:zip_code]).id
                      end
=end

describe 'registered user visits /conditions-dashboard' do
  describe 'on days with high temperature in 10 degree chunks' do
    it 'should see highest number of rides' do
    end
    it 'should see lowest number of rides' do
    end
    it 'should see average number of rides' do
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
