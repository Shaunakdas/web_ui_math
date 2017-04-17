require_relative '../Term'
describe Term do
	context "When testing the Term class" do

		it "Term: should say 'x' when we check initialize method" do
			term = Term.new()
			expect(term.toLatexString()).to eq ""
		end
		it "TermCoefficient: should say 'x' when we use TermVariable.new('x') and toLatexString() method" do
			term = Term.new()
			termVar = TermVariable.new("x")
			term.addTermItem(termVar)
			expect(term.toLatexString()).to eq "x"
		end
		it "TermCoefficient: should say 'x' when we use TermCoefficient.new(2) and toLatexString() method" do
			term = Term.new()
			termCoeff = TermCoefficient.new(2)
			term.addTermItem(termCoeff)
			expect(term.toLatexString()).to eq "2"
		end
		it "TermCoefficient & TermVariable: should say '2x' when we use TermVariable.new('x'), TermCoefficient.new(2) and toLatexString() method" do
			term = Term.new()
			termVar = TermVariable.new("x")
			term.addTermItem(termVar)
			termCoeff = TermCoefficient.new(2)
			term.addTermItem(termCoeff)
			expect(term.toLatexString()).to eq "2x"
		end
		it "Full TermCoefficient & Full TermVariable: should say '((-2^{2})(-x^{2}))^{2}' when we use TermVariable.new(-x^{2}), TermCoefficient.new(-2^{2}) and toLatexString() method" do
			term = Term.new()
			termVar = TermVariable.new("x")
			termVar.setNegative(true)
			termVar.setExponent(2)
			term.addTermItem(termVar)
			termCoeff = TermCoefficient.new(2)
			termCoeff.setNegative(true)
			termCoeff.setExponent(2)
			term.addTermItem(termCoeff)
			expect(term.toLatexString()).to eq "(-2^{2})(-x^{2})"
		end
		it "Full TermCoefficient & Full TermVariable, Negative & Exponent: should say '2x' when we use TermVariable.new(-x^{2}), TermCoefficient.new(-2^{2}) and toLatexString() method" do
			term = Term.new()
			termVar = TermVariable.new("x")
			termVar.setNegative(true)
			termVar.setExponent(2)
			term.addTermItem(termVar)
			termCoeff = TermCoefficient.new(2)
			termCoeff.setNegative(true)
			termCoeff.setExponent(2)
			term.addTermItem(termCoeff)
			term.setExponent(2)
			term.setNegative(true)
			expect(term.toLatexString()).to eq "-((-2^{2})(-x^{2}))^{2}"
		end
	end
end