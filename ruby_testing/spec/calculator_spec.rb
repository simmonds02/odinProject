
# describe - defines a group of tests
# it - defines a particular test

require './lib/calculator'

describe Calculator do 
    describe "#add" do
          it "returns the sum of two numbers" do
                        calculator = Calculator.new
                        expect(calculator.add(5,2)).to eql(7)
          end
          it "returns the sum of more than two numbers" do
                        calculator = Calculator.new
                        expect(calculator.add(7,5,2)).to eql(14)
          end
    end
    describe "#subtract" do
          it "returns the differnce of two numbers" do
                        calculator = Calculator.new
                        expect(calculator.subtract(5,2)).to eql(3)
          end
    end
end