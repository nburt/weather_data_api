require 'spec_helper'
require './lib/kelvin_converter'

describe KelvinConverter do

  it 'can convert Kelvin to Fahrenheit' do
    kelvin_converter = KelvinConverter.new(1)
    expect(kelvin_converter.convert('F')).to eq -457.87
  end

  it 'can convert Kelvin to Celsius' do
    kelvin_converter = KelvinConverter.new(1)
    expect(kelvin_converter.convert('C')).to eq -272.15
  end

end