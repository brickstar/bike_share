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

  7 total

  Trip.select.where("conditions*", count()).joins(:trips).joins(:conditions)

joins inner join trips on conditions.date = trips.start_date

  Condition.select("conditions.id, conditions.date")
  .where("max_temp >= ? AND max_temp <= ?", 40, 50)
  .pluck(:date)

  Condition.joins("INNER JOINS trips ON Conditions.date = trips.start_date").where("max_temp >= ? AND max_temp <= ?", 40, 50)

  def thing
    ary = [[40, 50], [50, 60], [60, 70], [70, 80], [80, 90], [90, 100], [100, 110]]
    thing = ary.map do |array|
      Condition.select("conditions.id, conditions.date").where("max_temp >= ? AND max_temp <= ?", array[0], array[1]).pluck(:date)
    end
    thing
  end

  thing.map do |ary|
    Trip.where(start_date: ary)
  end

=end

describe 'registered user visits /conditions-dashboard' do
  describe 'on days with high temperature in 10 degree chunks' do
    it 'should see average number of rides' do
    end
    it 'should see highest number of rides' do
    end
    it 'should see lowest number of rides' do
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
