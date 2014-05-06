require 'spec_helper'
require './lib/kelvin_converter'

describe KelvinConverter do

  it 'can convert Kelvin to Fahrenheit' do
    kelvin_converter = KelvinConverter.new(1)
    expect(kelvin_converter.fahrenheit).to eq -457.87
  end

end