# Bikeshare
<img width="1440" alt="readme-splash" src="https://user-images.githubusercontent.com/33355897/43535327-e3623b4c-9576-11e8-9b41-48c3e419373b.png">

#### Application
Bikeshare is a web application built with Ruby on Rails using Activerecord. It’s purpose is analyze bike share usage in San Francisco and allows users to purchase bike accessories via the online store. The application collects data directly from the browser through web forms, as well as by consuming CSV files containing historical anonymized bike trip data from the SF Bay Area Bike Share. Access the application via <https://jem-bikeshare.herokuapp.com>

---
#### Setup
- The database information for this application is from a San Francisco based bike share company.  This information can be downloaded from Kaggle, located at the following link: <https://www.kaggle.com/benhamner/sf-bay-area-bike-share>
- Once downloaded, the stations, trips and weather CSVs must be placed in a folder named 'sf-bay-area-bike-share' at the same level as your main application folder.
- You will have to run 'bundle' and 'bundle update' prior to running the application.  These commands will download the required gems required for the application to run.  In addition, you must run 'rake db:{drop,create,migrate,seed} in order to create the database utilized by the application for testing and development.  
- This application utilizes RSpec for testing.  In order to execute all tests, run the command 'rspec'

---

#### Gems Utilized
- BCrypt
- Byebug
- Pry
- Pry-rails
- Capybara
- RSpec-rails
- Launchy
- Shoulda-matchers
- Database_cleaner
- Simplecov
