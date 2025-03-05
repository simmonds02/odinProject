#Exercises

module Mudable
    def mudding
        puts "Woohooooo! We're mudding"
    end
end

class Vehicle
    @@number_of_vehicles = 0

    attr_accessor :current_speed, :color, :year, :model
    # attr_reader :year, :model

    def initialize(year, model, color)
        self.year = year
        self.model = model
        self.color = color
        self.current_speed = 0
        @@number_of_vehicles += 1
    end

    def self.total_number_of_vehicles
        puts @@number_of_vehicles
    end

    def self.gas_mileage(gallons, miles)
        #mpg needed
        #miles needed and gallons needed
        puts "#{miles/gallons} miles per gallon of gas"
    end

    def speed_up
        if current_speed < 140
            self.current_speed += 1
            puts current_speed
        end
    end

    def brake
        if current_speed > 0
            self.current_speed -= 1
            puts current_speed
        end
    end

    def shut_off
        self.current_speed = 0
        puts current_speed
        puts "i'm parked"
    end

    def spray_paint(new_color)
        self.color = new_color
        puts "my new color is #{color}"
    end

    def age
        puts "My vehicle is #{calculate_vehicles_age} years old"
    end

    private

    def calculate_vehicles_age
        vehicles_age = Time.now.year - year
    end
end

class MyCar < Vehicle
    VEHICLE_TYPE = "sedan"

    def to_s
        "My Car is a #{year} #{color} #{model}"
    end
end

class MyTruck < Vehicle
    include Mudable

    VEHICLE_TYPE = "truck"

    def to_s
        "My Truck is a #{year} #{color} #{model}"
    end
end

class Student
    attr_accessor :name
    attr_writer :grade

    def initialize(name, grade)  
        self.name = name
        self.grade = grade
    end

    def better_grade_than?(other_student)
        self.grade > other_student.grade
    end

    protected
    attr_reader :grade

end


puts Vehicle.ancestors    #use .ancestors to retrieve method lookup path
puts MyCar.ancestors    #use .ancestors to retrieve method lookup path
puts MyTruck.ancestors    #use .ancestors to retrieve method lookup path

buick = MyCar.new(2015, 'buick verano', 'black')
ram = MyTruck.new(2022, 'ram 1500', 'maroon')
puts buick
buick.speed_up
buick.current_speed
buick.speed_up
buick.current_speed
buick.brake
buick.current_speed
buick.brake
buick.current_speed
buick.shut_off
buick.current_speed
buick.spray_paint('red')
MyCar.gas_mileage(15, 450)
puts buick
puts ""
puts ram
ram.speed_up
ram.current_speed
ram.speed_up
ram.current_speed
ram.brake
ram.current_speed
ram.brake
ram.current_speed
ram.shut_off
ram.current_speed
ram.spray_paint('green')
MyTruck.gas_mileage(20, 450)
puts ram
ram.age

jamal = Student.new("jamal", 87)
bob = Student.new("bob", 66)

puts "Well done!" if jamal.better_grade_than?(bob)