require 'rails_helper'

=begin

As an admin user,
When I visit "/",
I see a link for "Login",

When I click "Login",
I should be on the "/login" page,
I see a place to insert my credentials to login,
I fill in my desired credentials,
I submit my information,
My current page should be "/admin/dashboard",
I see a message in the navbar that says "Logged in as Admin User: SOME_USER",
I see my profile information,
I do not see a link for "Login",
I see a link for "Logout"

=end

describe 'as an admin user' do
  describe 'visits root path and sees login link' do
    describe 'links to login form' do

    end
  end
end
