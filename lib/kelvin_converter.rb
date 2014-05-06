class KelvinConverter

  def initialize(temperature)
    @temperature = temperature
  end

  def convert(unit)
    if unit == 'Fahrenheit'
      (1.8 * (@temperature - 273.15 ) + 32).round(2)
    elsif unit == 'Celsius'
      (@temperature - 273.15).round(2)
    else
      @temperature.round(2)
    end
  end

end