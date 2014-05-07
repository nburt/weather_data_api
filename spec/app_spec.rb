require 'spec_helper'
require './app'
require 'capybara/rspec'

Capybara.app = App

feature 'Visitor can view weather data on the homepage' do

  scenario 'Visitor sees a welcome message on the homepage' do
    VCR.use_cassette('denver_weather') do
      visit '/'
      expect(page).to have_content 'Weather!'
    end
  end

  scenario 'visitor can select a city and state, Kelvin as the temperature type, and current weather and will see it on a display page' do
    VCR.use_cassette('denver_weather') do
      visit '/'
      fill_in 'city', :with => 'Denver'
      fill_in 'state', :with => 'CO'
      select 'Kelvin', :from => 'temperature_type'
      select 'Current Weather', :from => 'forecast_type'
      click_button 'Get Temperature'
      expect(page).to have_content 'Current Weather for Denver, CO'
      expect(page).to have_content 'Current Temperature: 295.58° K'
      expect(page).to have_content 'Minimum Temperature: 295.58° K'
      expect(page).to have_content 'Maximum Temperature: 295.58° K'
      click_link 'Check Another City'
      expect(page).to have_content 'Weather!'
    end
  end

  scenario 'visitor can select a seven day forecast' do
    VCR.use_cassette('denver_weather_7_day_forcast') do
      visit '/'
      fill_in 'city', :with => 'Denver'
      fill_in 'state', :with => 'CO'
      select 'Kelvin', :from => 'temperature_type'
      select 'Seven Day Forecast', :from => 'forecast_type'
      click_button 'Get Temperature'
      expect(page).to have_content 'Day: Monday'
      expect(page).to have_content 'Temperature for Day: 287.44° K'
      expect(page).to have_content 'Temperature for Night: 276.46° K'
      expect(page).to have_content 'Minimum Temperature: 276.46° K'
      expect(page).to have_content 'Maximum Temperature: 287.44° K'
      expect(page).to have_content 'Weather Type: Rain'
      expect(page).to have_content 'Weather Description: light rain'
    end
  end

end