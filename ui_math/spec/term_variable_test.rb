require_relative '../TermVariable'
describe TermVariable do
	context "When testing the TermVariable class" do

		it "Variable: should say 'x' when we check initialize method" do
			termVar = TermVariable.new("x")
			expect(termVar.toLatexString()).to eq "x"
		end
		it "Exponent: should say 'x' when we use setExponent(1) and toLatexString() method" do
			termVar = TermVariable.new("x")
			termVar.setExponent(1)
			expect(termVar.toLatexString()).to eq "x"
		end
		it "Exponent: should say 'x^2' when we use setExponent(2) and toLatexString() method" do
			termVar = TermVariable.new("x")
			termVar.setExponent(2)
			expect(termVar.toLatexString()).to eq "x^{2}"
		end
		it "Negative: should say '-x' when we use setNegative(false) and toLatexString() method" do
			termVar = TermVariable.new("x")
			termVar.setNegative(true)
			expect(termVar.toLatexString()).to eq "-x"
		end
		it "Exponent: should say '-x^2' when we use setExponent(2) and toLatexString() method" do
			termVar = TermVariable.new("x")
			termVar.setExponent(2)
			termVar.setNegative(true)
			expect(termVar.toLatexString()).to eq "-x^{2}"
		end
	end
end