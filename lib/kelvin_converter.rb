class KelvinConverter

  def initialize(temperature)
    @temperature = temperature
  end

  def convert(unit)
    if unit == 'F'
      (1.8 * (@temperature - 273.15 ) + 32).round(2)
    elsif unit == 'C'
      (@temperature - 273.15).round(2)
    end
  end

end