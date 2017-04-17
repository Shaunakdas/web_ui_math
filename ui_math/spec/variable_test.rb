require_relative '../Variable'
describe Variable do
	context "When testing the Variable class" do

		it "Symbol: should say 'x' when we call the toLatexString method " do
			var = Variable.new("x")
			latexString = var.toLatexString()
			expect(latexString).to eq "x"
		end
		it "Integer: should set substituteValue '4' when we call the setValue method with 4 value" do
			var = Variable.new("x")
			var.setValue(4)
			expect(var.substituteValue).to eq 4
		end
		it "Decimal: should set substituteValue '4.1' when we call the setValue method with 4.1 value" do
			var = Variable.new("x")
			var.setValue(4.1)
			expect(var.substituteValue).to eq 4.1
		end
		it "Negative: should set substituteNegative Negative when we call the setValue method with -4 value" do
			var = Variable.new("x")
			var.setValue(-4)
			expect(var.substituteNegative).to be true
		end
		it "Negative: should set substituteNegative Negative when we call the setValue method with 4 value" do
			var = Variable.new("x")
			var.setValue(4)
			expect(var.substituteNegative).to be false
		end
	end
end