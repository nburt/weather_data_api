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

  scenario 'visitor can enter a city Kelvin as the temperature type and will see it on a display page' do
    VCR.use_cassette('denver_weather') do
      visit '/'
      fill_in 'city', :with => 'Denver'
      fill_in 'state', :with => 'CO'
      select 'Kelvin', :from => 'temperature_type'
      click_button 'Get Temperature'
      expect(page).to have_content 'Current Weather for Denver, CO'
      expect(page).to have_content 'Current Temperature: 295.58 K'
      expect(page).to have_content 'Minimum Temperature: 295.58 K'
      expect(page).to have_content 'Maximum Temperature: 295.58 K'
      click_link 'Check Another City'
      expect(page).to have_content 'Weather!'
    end
  end
end