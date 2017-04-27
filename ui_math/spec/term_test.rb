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
		it "Full TermCoefficient & Full TermVariable: should say '((-2^{2})(-x^{2}))}^{2}' when we use TermVariable.new(-x^{2}), TermCoefficient.new(-2^{2}) and toLatexString() method" do
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
		it "Full TermCoefficient, Full TermVariable & Exponent0.5: should say '((-2^{2})(-x^{2}))}^{2}' when we use TermVariable.new(-x^{2}), TermCoefficient.new(-2^{2}) and toLatexString() method" do
			term = Term.new()
			termVar = TermVariable.new("x")
			termVar.setNegative(true)
			termVar.setExponent(2)
			term.addTermItem(termVar)
			termCoeff = TermCoefficient.new(2)
			termCoeff.setNegative(true)
			termCoeff.setExponent(2)
			term.addTermItem(termCoeff)
			term.setExponent(0.5)
			expect(term.toLatexString()).to eq "\\sqrt{((-2^{2})(-x^{2}))}"

		end
		it "simplifyItemExponent,simplifyItemNegative,simplifyExponent,simplifyNegative: should say '2x' when we use TermVariable.new(-x^{3}), TermCoefficient.new(-2^{3}) and toLatexString() method" do
			term = Term.new()
			termVar = TermVariable.new("x")
			termVar.setNegative(true)
			termVar.setExponent(3)
			term.addTermItem(termVar)
			termCoeff = TermCoefficient.new(2)
			termCoeff.setNegative(true)
			termCoeff.setExponent(3)
			term.addTermItem(termCoeff)
			term.setExponent(3)
			term.setNegative(true)
			expect(term.toLatexString()).to eq "-{((-2^{3})(-x^{3}))}^{3}"
			term.simplifyItemExponent()
			expect(term.toLatexString()).to eq "-{((-8)(-x^{3}))}^{3}"
			term.simplifyItemNegative()
			expect(term.toLatexString()).to eq "-{((-8)(-x^{3}))}^{3}"
			term.simplifyExponent()
			expect(term.toLatexString()).to eq "-(-8^{3})(-x^{9})"
			term.simplifyNegative()
			expect(term.toLatexString()).to eq "-8^{3}x^{9}"
		end
		it "simplifyCoefficient: should say '2x' when we use TermVariable.new(-x^{3}), TermCoefficient.new(-2^{3}) and toLatexString() method" do
			term = Term.new()
			term.addTermVariable("x",3,true)
			term.addTermCoefficient(2,3,true)
			term.setExponent(2)
			term.setNegative(true)
			expect(term.toLatexString()).to eq "-{((-2^{3})(-x^{3}))}^{2}"
			term.simplifyItemExponent()
			expect(term.toLatexString()).to eq "-{((-8)(-x^{3}))}^{2}"
			term.simplifyItemNegative()
			expect(term.toLatexString()).to eq "-{((-8)(-x^{3}))}^{2}"
			term.simplifyExponent()
			expect(term.toLatexString()).to eq "-8^{2}x^{6}"
			term.simplifyCoefficient()
			expect(term.toLatexString()).to eq "-64x^{6}"
		end
		it "simplifyVariable: should say '2x' when we use TermVariable.new(-x^{3}), TermCoefficient.new(-2^{3}) and toLatexString() method" do
			term = Term.new()
			term.addTermCoefficient(-2,3,false)
			term.addTermVariable("x",3,true)
			term.addTermCoefficient(2,3,true)
			term.addTermVariable("x",2,false)
			term.setExponent(2)
			term.setNegative(true)
			expect(term.toLatexString()).to eq "-{(((-2)^{3})(-2^{3})(-x^{3})x^{2})}^{2}"
			term.simplifyItemExponent()
			expect(term.toLatexString()).to eq "-{((-8)(-8)(-x^{3})x^{2})}^{2}"
			term.simplifyItemNegative()
			expect(term.toLatexString()).to eq "-{((-8)(-8)(-x^{3})x^{2})}^{2}"
			term.simplifyExponent()
			expect(term.toLatexString()).to eq "-8^{2}8^{2}x^{6}x^{4}"
			term.simplifyCoefficient()
			expect(term.toLatexString()).to eq "-4096x^{6}x^{4}"
			term.simplifyVariable()
			expect(term.toLatexString()).to eq "-4096x^{10}"
		end
		it "Multiple Variable: should say '2x' when we use TermVariable.new(-x^{3}), TermCoefficient.new(-2^{3}) and toLatexString() method" do
			term = Term.new()
			term.addTermCoefficient(-2,3,false)
			term.addTermVariable("x",3,true)
			term.addTermCoefficient(2,3,true)
			term.addTermVariable("y",2,false)
			term.setExponent(2)
			term.setNegative(true)
			expect(term.toLatexString()).to eq "-{(((-2)^{3})(-2^{3})(-x^{3})y^{2})}^{2}"
		end
		it "setValueList: should say '2x' when we use TermVariable.new(-x^{3}), TermCoefficient.new(-2^{3}) and toLatexString() method" do
			term = Term.new()
			term.addTermCoefficient(-2,3,false)
			term.addTermVariable("x",3,true)
			term.addTermCoefficient(1,3,true)
			term.addTermVariable("y",2,false)
			term.setExponent(2)
			term.setNegative(true)
			term.simplify()
			expect(term.toLatexString()).to eq "-64x^{6}y^{4}"
			var= Variable.new("x")
			var.setValue(-2)
			variableList =[var]
			term.setValueList(variableList)
			expect(term.toLatexString()).to eq "-64((-2)^{6})y^{4}"
			term.simplify()
			expect(term.toLatexString()).to eq "-4096y^{4}"
		end
		it "NegateTerm: should say '64x^{6}y^{4}' when we use TermVariable.new(-x^{3}), TermCoefficient.new(-2^{3}) and toLatexString() method" do
			term = Term.new()
			term.addTermCoefficient(-2,3,false)
			term.addTermVariable("x",3,true)
			term.addTermCoefficient(1,3,true)
			term.addTermVariable("y",2,false)
			term.setExponent(2)
			term.setNegative(true)
			term.simplify()
			expect(term.toLatexString()).to eq "-64x^{6}y^{4}"
			negatedTerm=term.negateTerm()
			expect(negatedTerm.toLatexString()).to eq "64x^{6}y^{4}"
			expect(term.toLatexString()).to eq "-64x^{6}y^{4}"
			negatedTerm=negatedTerm.negateTerm()
			expect(negatedTerm.toLatexString()).to eq "-64x^{6}y^{4}"
		end
		it "addCoefficientTerm: should say '64x^{6}y^{4}' when we use TermVariable.new(-x^{3}), TermCoefficient.new(-2^{3}) and toLatexString() method" do
			term1 = Term.new()
			term1.addTermCoefficient(-2,3,false)
			term1.setExponent(2)
			term1.setNegative(true)
			term2 = Term.new()
			term2.addTermCoefficient(1,3,true)
			expect(term1.toLatexString()).to eq "-{(((-2)^{3}))}^{2}"
			expect(term2.toLatexString()).to eq "(-1^{3})"
			term1 = term1.addCoefficientTerm(term2)
			expect(term1.toLatexString()).to eq "-65"
			expect(term2.toLatexString()).to eq "(-1^{3})"
			term1 = term1.subtractCoefficientTerm(term2)
			expect(term1.toLatexString()).to eq "-64"
			term1 = term1.multiplyCoefficientTerm(term2)
			expect(term1.toLatexString()).to eq "64"
		end
		it "getVariableList: should say '2x' when we use TermVariable.new(-x^{3}), TermCoefficient.new(-2^{3}) and toLatexString() method" do
			term = Term.new()
			term.addTermCoefficient(-2,3,false)
			term.addTermVariable("x",3,true)
			term.addTermCoefficient(1,3,true)
			term.addTermVariable("y",2,false)
			term.setExponent(2)
			term.setNegative(true)
			term.simplify()
			expect(term.toLatexString()).to eq "-64x^{6}y^{4}"
			expect(term.getVariableList().join(",").to_s).to eq "x,y"
			term.termItemList = [TermVariable.new("x"),TermCoefficient.new(4),TermVariable.new("x")]
			expect(term.toLatexString()).to eq "-4xx"
			expect(term.getVariableList().join(",").to_s).to eq "x"
		end
	end
end