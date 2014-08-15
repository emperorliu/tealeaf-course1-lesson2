1. 

@a = 2

a is an instance variable that is set to the Fixnum object with value 2.

user = User.new

user is an object that was initialized from the User.

user.name

the "name" method is being called on the user object. (getting the name variable)

user.name = "Joe"

the setter method is being called on the user name method, changing the user name to "Joe"

2. It mixes in a module by using the "include" word. Modules use snakecase.

3. Class variables are shared among the class and all its descendants and is denoted by using two @@ signs.

4. attr_accessor allows you to use the getter and setter methods on an instant variable.

5. Dog.some_method would be calling the some_method method on the Dog class. (a class method)

6. Subclassing refers to a "is-a" relationship, and modules refer to a "has-a" relationship.

7. def initialize(n)
      @name = n
    end

8. Yes.

9. binding.pry

