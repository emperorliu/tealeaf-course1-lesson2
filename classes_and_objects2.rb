class MyCar
  attr_accessor :color
  attr_reader :year

  def initialize(year, model, color)
    @year = year
    @model = model
    @color = color
    @current_speed = 0
  end

  def speed_up(number)
    @current_speed += number
    puts "You just push the gas and accelerate #{number} mph"
  end

  def current_speed
    puts "You are now going #{@current_speed} mph"
  end

  def brake(number)
    @current_speed -= number
    puts "You push the break and decelerate #{number} mph"
  end

  def shut_down
    @current_speed = 0
    puts "Let's park this car"
  end

  def spray_paint(color)
    self.color = color
  end

  def self.gas_mileage(gallons, miles)
    puts "#{miles / gallons} miles per gallon of gas"
  end

  def to_s
    "This is my car, it's a #{self.color}, #{self.year}, #{@model}!"
  end

end

MyCar.gas_mileage(10,300)

my_car = MyCar.new("2010", "Ford Focus", "Silver")
puts my_car

puts "---------------"

#2

We get this error because we only have a getter method for name and no setter method, we need to change it to attr_accessor 