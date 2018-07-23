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
