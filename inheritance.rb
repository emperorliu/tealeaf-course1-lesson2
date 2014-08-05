module Towable
  def can_tow?(pounds)
    pounds < 2000 ? true : false
  end
end

class Vehicle
  attr_accessor :color
  attr_reader :year

  @@number_of_vehicles = 0

  def self.number_of_vehicles
    puts "You have #{@@number_of_vehicles} vehicles"
  end

  def initialize(year, model, color)
    @year = year
    @model = model
    @color = color
    @current_speed = 0
    @@number_of_vehicles += 1
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

  def print_out_age
    puts "My car is #{age} years old"
  end

  private

  def age
    Time.now.year - self.year.to_i
  end
end


class MyCar < Vehicle
  NUMBER_OF_DOORS = 4

  def to_s
    "This is my car, it's a #{self.color}, #{self.year}, #{@model}!"
  end

end

class MyTruck < Vehicle
  NUMBER_OF_DOORS = 2

  include Towable

  def to_s
    "This is my truck, it's a #{self.color}, #{self.year}, #{@model}!"
  end
end

MyCar.gas_mileage(10,300)

my_car = MyCar.new("2010", "Ford Focus", "Silver")
truck = MyTruck.new("2010", "Ford Tundra", "White")

puts my_car
puts truck

Vehicle.number_of_vehicles

puts truck.can_tow?(400)

puts "Vehicle lookup"
puts Vehicle.ancestors
puts "---------"
puts "My Car Lookup"
puts MyCar.ancestors
puts "---------"
puts "My Truck lookup"
puts MyTruck.ancestors
puts "---------"

puts my_car.print_out_age


puts " # 2 -----------------------"

class Student

  def initialize(name, grade)
    @name = name
    @grade = grade 
  end

  def better_grade_than?(other_student)
    grade > other_student.grade
  end

  protected

  def grade
    @grade
  end
end

joe = Student.new("Joe", 93)
bob = Student.new("Bob", 78)

puts joe.better_grade_than?(bob)

puts " # 3 ---------------------"

puts "The method 'hi' is private and cannot be called by the object outside the class. In order to fix it, you can make it a public method."