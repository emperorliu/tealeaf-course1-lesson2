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

end

my_car = MyCar.new('1975', 'Toyota', 'red')
my_car.current_speed
my_car.speed_up(20)
my_car.current_speed
my_car.brake(14)
my_car.current_speed
my_car.shut_down
my_car.current_speed

my_car.color = "black"

puts my_car.color
puts my_car.year

my_car.spray_paint('red')
puts my_car.color

puts "---------------"