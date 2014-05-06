class KelvinConverter

  def initialize(temperature)
    @temperature = temperature
  end

  def fahrenheit
    (1.8 * (@temperature - 273.15) + 32).round(2)
  end

end