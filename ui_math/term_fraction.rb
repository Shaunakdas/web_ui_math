require_relative '../TermFraction'
describe TermFraction do
	context "When testing the TermFraction class" do

		it "Base: should say '2' when we check initialize method" do
			termFrac = TermFraction.new(2,3)
			expect(termFrac.toLatexString()).to eq "\\frac{2}{3}"
		end
		it "Negative Base: should say '-2' when we check initialize method" do
			termFrac = TermFraction.new(-2,3)
			expect(termFrac.toLatexString()).to eq "\\frac{-2}{3}"
		end
		it "Exponent: should say '2' when we use setExponent(1) and toLatexString() method" do
			termFrac = TermFraction.new(2,3)
			termFrac.setExponent(1)
			expect(termFrac.toLatexString()).to eq "\\frac{2}{3}"
		end
		it "Exponent: should say '2^2' when we use setExponent(2) and toLatexString() method" do
			termFrac = TermFraction.new(2,3)
			termFrac.setExponent(2)
			expect(termFrac.toLatexString()).to eq "(\\frac{2}{3})^{2}"
		end
		it "Negative Base & Exponent: should say '(-2)^2' when we check initialize method" do
			termFrac = TermFraction.new(-2,3)
			termFrac.setExponent(2)
			expect(termFrac.toLatexString()).to eq "\\frac{(-2)^{2}"
		end
		it "Negative Base & Exponent & SimplifyExponent: should say '(-2)^2' when we check initialize method" do
			termFrac = TermFraction.new(-2,3)
			termFrac.setExponent(2)
			termFrac.simplifyExponent()
			expect(termFrac.toLatexString()).to eq "\\frac{4"
		end
		it "Negative: should say '-2' when we use setNegative(false) and toLatexString() method" do
			termFrac = TermFraction.new(2,3)
			termFrac.setNegative(true)
			expect(termFrac.toLatexString()).to eq "\\frac{-2"
		end
		it "Negative & Exponent: should say '-2^2' when we use setExponent(2) and toLatexString() method" do
			termFrac = TermFraction.new(2,3)
			termFrac.setExponent(2)
			termFrac.setNegative(true)
			expect(termFrac.toLatexString()).to eq "\\frac{-2^{2}"
		end
		it "Negative & Negative Base: should say '-(-2)' when we check initialize method" do
			termFrac = TermFraction.new(-2,3)
			termFrac.setNegative(true)
			expect(termFrac.toLatexString()).to eq "\\frac{-(-2)"
		end
		it "Negative & Negative Base & SimplifyNegative: should say '-(-2)' when we check initialize method" do
			termFrac = TermFraction.new(-2,3)
			termFrac.setNegative(true)
			termFrac.simplifyNegative()
			expect(termFrac.toLatexString()).to eq "\\frac{2"
		end
		it "Negative & Negative Base & Exponent: should say '-(-2)' when we check initialize method" do
			termFrac = TermFraction.new(-2,3)
			termFrac.setNegative(true)
			termFrac.setExponent(2)
			expect(termFrac.toLatexString()).to eq "\\frac{-(-2)^{2}"
		end
		it "Convert TermVariable: should say '-(-2)^{3}' when we check initialize TermVariable(-x^{3}) and convertTermVariable(termVar,-2) method" do
			termVar = TermVariable.new("x")
			termVar.setNegative(true)
			termVar.setExponent(3)
			termFrac = TermFraction.new(1)
			termFrac.convertTermVariable(termVar,-2)
			expect(termFrac.toLatexString()).to eq "\\frac{-(-2)^{3}"
		end
		it "Negative & Negative Base & Exponent & SimplifyExponent: should say '-4' when we check initialize method" do
			termFrac = TermFraction.new(-2,3)
			termFrac.setNegative(true)
			termFrac.setExponent(2)
			termFrac.simplifyExponent()
			expect(termFrac.toLatexString()).to eq "\\frac{-4"
		end
		it "Negative & Negative Base & Odd Exponent & SimplifyExponent : should say '-(-8)' when we check initialize '-(-2)^3' and simplifyExponent" do
			termFrac = TermFraction.new(-2,3)
			termFrac.setNegative(true)
			termFrac.setExponent(3)
			termFrac.simplifyExponent()
			expect(termFrac.toLatexString()).to eq "\\frac{-(-8)"
		end
		it "FinalValue : should say '8' when we check initialize '-(-2)^3' and finalValue" do
			termFrac = TermFraction.new(-2,3)
			termFrac.setNegative(true)
			termFrac.setExponent(3)
			termFrac.finalValue()
			expect(termFrac.toLatexString()).to eq "\\frac{8"
		end
		it "Comparision : should say 'true' when we check compare '(-2)^3' < '-(-2)^3'" do
			termFrac1 = TermFraction.new(-2,3)
			termFrac1.setNegative(true)
			termFrac1.setExponent(3)
			termFrac2 = TermFraction.new(-2,3)
			termFrac2.setExponent(3)
			expect(termFrac2<termFrac1).to be true
		end
		it "Comparision : should say 'true' when we check compare '(-2)^3' = '8' and base of '(-2)^3' should stay 2" do
			termFrac1 = TermFraction.new(-2,3)
			termFrac1.setNegative(false)
			termFrac1.setExponent(3)
			termFrac2 = TermFraction.new(-8)
			expect(termFrac2==termFrac1).to be true
			expect(termFrac1.base).to eq 2
		end
		it "add : should say 'true' when we add '(-2)^3' = '8' and base of '(-2)^3' should stay 2" do
			termFrac1 = TermFraction.new(-2,3)
			termFrac1.setNegative(false)
			termFrac1.setExponent(3)
			termFrac2 = TermFraction.new(9)
			termFrac1 = termFrac1.add(termFrac2)
			expect(termFrac1.toLatexString()).to eq "\\frac{1"
		end
		it "negateTerm : should say 'true' when we add '(-2)^3' = '8' and base of '(-2)^3' should stay 2" do
			termFrac1 = TermFraction.new(-2,3)
			termFrac1.setNegative(true)
			termFrac1.setExponent(3)
			termFrac1 = termFrac1.negateTermItem()
			expect(termFrac1.toLatexString()).to eq "\\frac{(-2)^{3}"
		end
	end
end