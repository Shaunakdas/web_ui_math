require_relative '../TermCoefficient'
describe TermCoefficient do
	context "When testing the TermCoefficient class" do

		it "Base: should say '2' when we check initialize method" do
			termCoeff = TermCoefficient.new(2)
			expect(termCoeff.toLatexString()).to eq "2"
		end
		it "Negative Base: should say '-2' when we check initialize method" do
			termCoeff = TermCoefficient.new(-2)
			expect(termCoeff.toLatexString()).to eq "-2"
		end
		it "Exponent: should say '2' when we use setExponent(1) and toLatexString() method" do
			termCoeff = TermCoefficient.new(2)
			termCoeff.setExponent(1)
			expect(termCoeff.toLatexString()).to eq "2"
		end
		it "Exponent: should say '2^2' when we use setExponent(2) and toLatexString() method" do
			termCoeff = TermCoefficient.new(2)
			termCoeff.setExponent(2)
			expect(termCoeff.toLatexString()).to eq "2^{2}"
		end
		it "Negative Base & Exponent: should say '(-2)^2' when we check initialize method" do
			termCoeff = TermCoefficient.new(-2)
			termCoeff.setExponent(2)
			expect(termCoeff.toLatexString()).to eq "(-2)^{2}"
		end
		it "Negative Base & Exponent & SimplifyExponent: should say '(-2)^2' when we check initialize method" do
			termCoeff = TermCoefficient.new(-2)
			termCoeff.setExponent(2)
			termCoeff.simplifyExponent()
			expect(termCoeff.toLatexString()).to eq "4"
		end
		it "Negative: should say '-2' when we use setNegative(false) and toLatexString() method" do
			termCoeff = TermCoefficient.new(2)
			termCoeff.setNegative(true)
			expect(termCoeff.toLatexString()).to eq "-2"
		end
		it "Negative & Exponent: should say '-2^2' when we use setExponent(2) and toLatexString() method" do
			termCoeff = TermCoefficient.new(2)
			termCoeff.setExponent(2)
			termCoeff.setNegative(true)
			expect(termCoeff.toLatexString()).to eq "-2^{2}"
		end
		it "Negative & Negative Base: should say '-(-2)' when we check initialize method" do
			termCoeff = TermCoefficient.new(-2)
			termCoeff.setNegative(true)
			expect(termCoeff.toLatexString()).to eq "-(-2)"
		end
		it "Negative & Negative Base & SimplifyNegative: should say '-(-2)' when we check initialize method" do
			termCoeff = TermCoefficient.new(-2)
			termCoeff.setNegative(true)
			termCoeff.simplifyNegative()
			expect(termCoeff.toLatexString()).to eq "2"
		end
		it "Negative & Negative Base & Exponent: should say '-(-2)' when we check initialize method" do
			termCoeff = TermCoefficient.new(-2)
			termCoeff.setNegative(true)
			termCoeff.setExponent(2)
			expect(termCoeff.toLatexString()).to eq "-(-2)^{2}"
		end
		it "Convert TermVariable: should say '-(-2)^{3}' when we check initialize TermVariable(-x^{3}) and convertTermVariable(termVar,-2) method" do
			termVar = TermVariable.new("x")
			termVar.setNegative(true)
			termVar.setExponent(3)
			termCoeff = TermCoefficient.new(1)
			termCoeff.convertTermVariable(termVar,-2)
			expect(termCoeff.toLatexString()).to eq "-(-2)^{3}"
		end
		it "Negative & Negative Base & Exponent & SimplifyExponent: should say '-4' when we check initialize method" do
			termCoeff = TermCoefficient.new(-2)
			termCoeff.setNegative(true)
			termCoeff.setExponent(2)
			termCoeff.simplifyExponent()
			expect(termCoeff.toLatexString()).to eq "-4"
		end
		it "Negative & Negative Base & Odd Exponent & SimplifyExponent : should say '-(-8)' when we check initialize '-(-2)^3' and simplifyExponent" do
			termCoeff = TermCoefficient.new(-2)
			termCoeff.setNegative(true)
			termCoeff.setExponent(3)
			termCoeff.simplifyExponent()
			expect(termCoeff.toLatexString()).to eq "-(-8)"
		end
		it "FinalValue : should say '8' when we check initialize '-(-2)^3' and finalValue" do
			termCoeff = TermCoefficient.new(-2)
			termCoeff.setNegative(true)
			termCoeff.setExponent(3)
			termCoeff.finalValue()
			expect(termCoeff.toLatexString()).to eq "8"
		end
		it "Comparision : should say 'true' when we check compare '(-2)^3' < '-(-2)^3'" do
			termCoeff1 = TermCoefficient.new(-2)
			termCoeff1.setNegative(true)
			termCoeff1.setExponent(3)
			termCoeff2 = TermCoefficient.new(-2)
			termCoeff2.setExponent(3)
			expect(termCoeff2<termCoeff1).to be true
		end
		it "Comparision : should say 'true' when we check compare '(-2)^3' = '8' and base of '(-2)^3' should stay 2" do
			termCoeff1 = TermCoefficient.new(-2)
			termCoeff1.setNegative(false)
			termCoeff1.setExponent(3)
			termCoeff2 = TermCoefficient.new(-8)
			expect(termCoeff2==termCoeff1).to be true
			expect(termCoeff1.base).to eq 2
		end
		it "add : should say 'true' when we add '(-2)^3' = '8' and base of '(-2)^3' should stay 2" do
			termCoeff1 = TermCoefficient.new(-2)
			termCoeff1.setNegative(false)
			termCoeff1.setExponent(3)
			termCoeff2 = TermCoefficient.new(9)
			termCoeff1 = termCoeff1.add(termCoeff2)
			expect(termCoeff1.toLatexString()).to eq "1"
		end
		it "negateTerm : should say 'true' when we add '(-2)^3' = '8' and base of '(-2)^3' should stay 2" do
			termCoeff1 = TermCoefficient.new(-2)
			termCoeff1.setNegative(true)
			termCoeff1.setExponent(3)
			termCoeff1 = termCoeff1.negateTermItem()
			expect(termCoeff1.toLatexString()).to eq "(-2)^{3}"
		end
	end
end