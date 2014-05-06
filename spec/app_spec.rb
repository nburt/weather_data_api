require 'spec_helper'
require './app'
require 'capybara/rspec'

Capybara.app = App

feature 'Visitor can view weather data on the homepage' do

  scenario 'Visitor sees a welcome message on the homepage' do
    visit '/'
    expect(page).to have_content 'Weather!'
  end
end