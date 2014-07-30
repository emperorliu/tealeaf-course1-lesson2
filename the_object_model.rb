1. We create an object by initializing it as an instance of a class. For example,

class Human
end

jeff = Human.new

2. A module is a collection of behaviors useable in other classes via mixins. A module is "mixed in" to a class using the include reserved word.

module Eat
    def eat(food)
      puts "I'm eating #{food}."
    end
end

class Human
  include Eat
end

jeff = Human.new
jeff.eat("Ramen")

Modules can also be used for namespacing.

