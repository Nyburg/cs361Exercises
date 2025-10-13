class Car
  def initialize(name)
    @name = name
  end

  def drive
    puts "#{@name} is driving"
  end
end

car1 = Car.new("Subaru Crosstrek")
car2 = Car.new("Tesla Model S")

car1.drive
car2.drive
