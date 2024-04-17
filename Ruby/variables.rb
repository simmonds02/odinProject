### Variables

# Declaring a Variable
age = 18 #=> 18

age = 18 + 5 #=> 23

age = 18
age #=> 18
age = 33
age #=> 33

age = 18
age #=> 18
age = age + 4
age #=> 22

age = 18
age += 4 #=> 22

age = 18
age -= 2  #=> 16

cash = 10
cash *= 2 #=> 20

temperature = 40
temperature /= 10 #=> 4

# Naming
# bad
a = 19
string = "John"

# good
age = 19
name = "John"
can_swim = false

##Launch School Exercises 
 puts "What's your First name?"
 first_name = gets.chomp
 puts "What's your Last name?"
 last_name = gets.chomp
 10.times do |n|
  puts "Welcome " + first_name + " " + last_name + "!"
 end

 puts "How old are you?"
 age = gets.chomp.to_i
 puts "In 10 years you will be: #{age+10}"
 puts "In 20 years you will be: #{age+20}"
 puts "In 30 years you will be: #{age+30}"
 puts "In 40 years you will be: #{age+40}"

##Practice

