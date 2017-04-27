require_relative '../Expression'
describe Expression do
	context "When testing the Term class" do

		it "Term: should say '' when we check initialize method" do
			exp = Expression.new()
			expect(exp.toLatexString()).to eq ""
		end
		it "TermCoefficient: should say 'x' when we use TermVariable.new('x') and toLatexString() method" do
			exp = Expression.new()
			termVar = TermVariable.new("x")
			exp.expressionItemList = [termVar]
			expect(exp.toLatexString()).to eq "x"
		end
		it "TermCoefficient: should say 'x' when we use TermCoefficient.new(2) and toLatexString() method" do
			exp = Expression.new()
			termCoeff = TermCoefficient.new(2)
			exp.expressionItemList = [termCoeff]
			expect(exp.toLatexString()).to eq "2"
		end
		it "TermCoefficient & TermVariable: should say '2x' when we use TermVariable.new('x'), TermCoefficient.new(2) and toLatexString() method" do
			exp = Expression.new()
			termVar = TermVariable.new("x")
			termCoeff = TermCoefficient.new(2)
			exp.expressionItemList = [termCoeff,termVar]
			expect(exp.toLatexString()).to eq "2x"
		end
		it "Full TermCoefficient & Full TermVariable: should say '(-2^{2})(-x^{2})' when we use TermVariable.new(-2^{2}), TermCoefficient.new(-x^{2}) and toLatexString() method" do
			exp = Expression.new()
			termVar = TermVariable.new("x")
			termVar.setNegative(true)
			termVar.setExponent(2)
			termCoeff = TermCoefficient.new(2)
			termCoeff.setNegative(true)
			termCoeff.setExponent(2)
			exp.expressionItemList = [termCoeff,termVar]
			expect(exp.toLatexString()).to eq "(-2^{2})(-x^{2})"

		end
		it "Full TermCoefficient, Operator & Full TermVariable: should say '(-2^{2})(-x^{2})' when we use TermVariable.new(-2^{2}), Operator.new("+"), TermCoefficient.new(-x^{2}) and toLatexString() method" do
			exp = Expression.new()
			termVar = TermVariable.new("x")
			termVar.setNegative(true)
			termVar.setExponent(2)
			termCoeff = TermCoefficient.new(2)
			termCoeff.setNegative(true)
			termCoeff.setExponent(2)
			exp.expressionItemList = [termCoeff,Operator.new("+"),termVar]
			expect(exp.toLatexString()).to eq "(-2^{2})+(-x^{2})"

		end
		it "Full TermCoefficient, Operator, Full TermVariable & Exponent: should say '(-2^{2})(-x^{2})' when we use TermVariable.new(-2^{2}), Operator.new("+"), TermCoefficient.new(-x^{2}) and toLatexString() method" do
			exp = Expression.new()
			termVar = TermVariable.new("x")
			termVar.setNegative(true)
			termVar.setExponent(2)
			termCoeff = TermCoefficient.new(2)
			termCoeff.setNegative(true)
			termCoeff.setExponent(2)
			exp.expressionItemList = [termCoeff,Operator.new("+"),termVar]
			exp.setNegative(true)
			exp.setExponent(2)
			expect(exp.toLatexString()).to eq "-{((-2^{2})+(-x^{2}))}^{2}"

		end
		it "Full TermCoefficient, Operator, Full TermVariable & Negative: should say '(-2^{2})(-x^{2})' when we use TermVariable.new(-2^{2}), Operator.new("+"), TermCoefficient.new(-x^{2}) and toLatexString() method" do
			exp = Expression.new()
			termVar = TermVariable.new("x")
			termVar.setNegative(true)
			termVar.setExponent(2)
			termCoeff = TermCoefficient.new(2)
			termCoeff.setNegative(true)
			termCoeff.setExponent(2)
			exp.expressionItemList = [termCoeff,Operator.new("+"),termVar]
			exp.setNegative(true)
			expect(exp.toLatexString()).to eq "-{((-2^{2})+(-x^{2}))}"

		end
		it "Full TermCoefficient, Operator, Full TermVariable & Term: should say '2^{2}+x^{2}' when we use TermCoefficient.new(2^{2}), Operator.new("+"), TermCoefficient.new(x^{2}) and toLatexString() method" do
			exp = Expression.new()
			termVar = TermVariable.new("x")
			termVar.setExponent(2)
			termCoeff = TermCoefficient.new(2)
			termCoeff.setExponent(2)
			term= Term.new()
			term.termItemList = [termVar,termCoeff]
			exp.expressionItemList = [termCoeff,Operator.new("+"),termVar,Operator.new("-"),term]
			expect(exp.toLatexString()).to eq "2^{2}+x^{2}-2^{2}x^{2}"

		end
		it "Full TermCoefficient, Operator, Full TermVariable, Term & Exponent: should say '2^{2}+x^{2}' when we use TermCoefficient.new(2^{2}), Operator.new("+"), TermCoefficient.new(x^{2}) and toLatexString() method" do
			exp = Expression.new()
			termVar = TermVariable.new("x")
			termVar.setExponent(2)
			termCoeff = TermCoefficient.new(2)
			termCoeff.setExponent(2)
			term= Term.new()
			term.termItemList = [termVar,termCoeff]
			exp.expressionItemList = [termCoeff,Operator.new("+"),termVar,Operator.new("-"),term]
			exp.setExponent(2)
			expect(exp.toLatexString()).to eq "{(2^{2}+x^{2}-2^{2}x^{2})}^{2}"

		end
		it "Full TermCoefficient, Operator, Full TermVariable, Term, TermFraction: should say '2^{2}+x^{2}' when we use TermCoefficient.new(2^{2}), Operator.new("+"), TermCoefficient.new(x^{2}) and toLatexString() method" do
			exp = Expression.new()
			termVar = TermVariable.new("x")
			termVar.setExponent(2)
			termCoeff = TermCoefficient.new(2)
			termCoeff.setExponent(2)
			term= Term.new()
			term.termItemList = [termVar,termCoeff]
			termFraction= TermFraction.new(termCoeff,termCoeff)
			exp.expressionItemList = [termCoeff,Operator.new("+"),termVar,Operator.new("-"),term,Operator.new("\\div"),termFraction]
			expect(exp.toLatexString()).to eq "2^{2}+x^{2}-2^{2}x^{2}\\div\\frac{2^{2}}{2^{2}}"

		end
		it "Full TermCoefficient, Operator, Full TermVariable, Term, TermFraction & Expression Exponent: should say '2^{2}+x^{2}' when we use TermCoefficient.new(2^{2}), Operator.new("+"), TermCoefficient.new(x^{2}) and toLatexString() method" do
			exp = Expression.new()
			termVar = TermVariable.new("x")
			termVar.setExponent(2)
			termCoeff = TermCoefficient.new(2)
			termCoeff.setExponent(2)
			term= Term.new()
			term.termItemList = [termVar,termCoeff]
			termFraction= TermFraction.new(-3,4)
			termFraction.setExponent(2)
			exp.expressionItemList = [termCoeff,Operator.new("+"),termVar,Operator.new("-"),term,Operator.new("\\div"),termFraction]
			expect(exp.toLatexString()).to eq "2^{2}+x^{2}-2^{2}x^{2}\\div{(\\frac{-3}{4})}^{2}"

		end
		it "Full TermCoefficient, Operator, Full TermVariable, Term, TermFraction ,Expression & Expression Exponent: should say '2^{2}+x^{2}' when we use TermCoefficient.new(2^{2}), Operator.new("+"), TermCoefficient.new(x^{2}) and toLatexString() method" do
			exp = Expression.new()
			termVar = TermVariable.new("x")
			termVar.setExponent(2)
			termCoeff = TermCoefficient.new(2)
			termCoeff.setExponent(2)
			term= Term.new()
			term.termItemList = [termVar,termCoeff]
			termFraction= TermFraction.new(-3,4)
			termFraction.setExponent(2)
			exp.expressionItemList = [termCoeff,Operator.new("+"),termVar,Operator.new("-"),term,Operator.new("\\div"),termFraction]
			biggerExp = Expression.new()
			biggerExp.expressionItemList = [exp,Operator.new("<"),term.negateTerm()]
			expect(biggerExp.toLatexString()).to eq "2^{2}+x^{2}-2^{2}x^{2}\\div{(\\frac{-3}{4})}^{2}<(-2^{2}x^{2})"

		end
		it "Full TermCoefficient, Operator & Full TermVariable-Negative: should say '2^{2}+x^{2}' when we use TermCoefficient.new(2^{2}), Operator.new("+"), TermCoefficient.new(x^{2}) and toLatexString() method" do
			exp = Expression.new()
			termVar = TermVariable.new("x")
			termVar.setNegative(true)
			termCoeff = TermCoefficient.new(2)
			termCoeff.setNegative(true)
			exp.expressionItemList = [termCoeff,Operator.new("+"),termVar]
			expect(exp.toLatexString()).to eq "(-2)+(-x)"

		end
		it "exponentFlag(): should say true for exponentFlag when we use TermVariable.new(x), Operator.new("+"), TermCoefficient.new(2), setExponent and exponentFlag() method" do
			exp = Expression.new()
			termVar = TermVariable.new("x")
			termCoeff = TermCoefficient.new(2)
			exp.expressionItemList = [termCoeff,Operator.new("+"),termVar]
			expect(exp.toLatexString()).to eq "2+x"
			exp.setExponent(2)
			expect(exp.toLatexString()).to eq "{(2+x)}^{2}"
			expect(exp.exponentFlag()).to be true
		end
		it "negativeFlag(): should say true for negativeFlag when we use TermVariable.new(x), Operator.new("+"), TermCoefficient.new(2), setNegative and negativeFlag() method" do
			exp = Expression.new()
			termVar = TermVariable.new("x")
			termCoeff = TermCoefficient.new(2)
			exp.expressionItemList = [termCoeff,Operator.new("+"),termVar]
			expect(exp.toLatexString()).to eq "2+x"
			exp.setNegative(true)
			expect(exp.toLatexString()).to eq "-{(2+x)}"
			expect(exp.negativeFlag()).to be true
		end
		it "addExpressionItem: Full TermCoefficient, Operator, Full TermVariable, Term, TermFraction & Expression Exponent: should say '2^{2}+x^{2}' when we use TermCoefficient.new(2^{2}), Operator.new("+"), TermCoefficient.new(x^{2}) and toLatexString() method" do
			exp = Expression.new()
			termCoeff = TermCoefficient.new(2)
			termCoeff.setExponent(2)
			exp.addExpressionItem(termCoeff)
			expect(exp.toLatexString()).to eq "2^{2}"
			termVar = TermVariable.new("x")
			termVar.setExponent(2)
			exp.addExpressionItem(Operator.new("+"))
			exp.addExpressionItem(termVar)
			expect(exp.toLatexString()).to eq "2^{2}+x^{2}"
			term= Term.new()
			term.termItemList = [termVar,termCoeff]
			exp.addExpressionItem(Operator.new("-"))
			exp.addExpressionItem(term)
			expect(exp.toLatexString()).to eq "2^{2}+x^{2}-2^{2}x^{2}"
			termFraction= TermFraction.new(-3,4)
			termFraction.setExponent(2)
			exp.addExpressionItem(Operator.new("\\div"))
			exp.addExpressionItem(termFraction)
			expect(exp.toLatexString()).to eq "2^{2}+x^{2}-2^{2}x^{2}\\div{(\\frac{-3}{4})}^{2}"
			
		end
		it "consistsVariable() & consistsCoefficient(): Full TermCoefficient, Operator, Full TermVariable, Term, TermFraction & Expression Exponent: should say '2^{2}+x^{2}' when we use TermCoefficient.new(2^{2}), Operator.new("+"), TermCoefficient.new(x^{2}) and toLatexString() method" do
			exp = Expression.new()
			termVar = TermVariable.new("x")
			termVar.setExponent(2)
			termCoeff = TermCoefficient.new(2)
			termCoeff.setExponent(2)
			term= Term.new()
			term.termItemList = [termVar,termCoeff]
			termFraction= TermFraction.new(-3,4)
			termFraction.setExponent(2)
			exp.expressionItemList = [termCoeff,Operator.new("+"),termFraction]
			expect(exp.toLatexString()).to eq "2^{2}+{(\\frac{-3}{4})}^{2}"
			expect(exp.consistsVariable()).to be false
			expect(exp.consistsCoefficient()).to be true
			exp.expressionItemList = [termVar]
			expect(exp.toLatexString()).to eq "x^{2}"
			expect(exp.consistsVariable()).to be true
			expect(exp.consistsCoefficient()).to be false
			exp.expressionItemList = [termVar,Operator.new("-"),term]
			expect(exp.toLatexString()).to eq "x^{2}-2^{2}x^{2}"
			expect(exp.consistsVariable()).to be true
			expect(exp.consistsCoefficient()).to be true
			exp.expressionItemList = [termCoeff,Operator.new("+"),termVar,Operator.new("-"),term,Operator.new("\\div"),termFraction]
			expect(exp.toLatexString()).to eq "2^{2}+x^{2}-2^{2}x^{2}\\div{(\\frac{-3}{4})}^{2}"
			expect(exp.consistsVariable()).to be true
			expect(exp.consistsCoefficient()).to be true
		end
		it "negateExpression: Full TermCoefficient, Operator & Full TermVariable-Negative: should say '2^{2}+x^{2}' when we use TermCoefficient.new(2^{2}), Operator.new("+"), TermCoefficient.new(x^{2}) and toLatexString() method" do
			exp = Expression.new()
			termVar = TermVariable.new("x")
			termVar.setNegative(true)
			termCoeff = TermCoefficient.new(2)
			termCoeff.setNegative(true)
			exp.expressionItemList = [termCoeff,Operator.new("+"),termVar]
			expect(exp.toLatexString()).to eq "(-2)+(-x)"
			exp1 = Expression.new(); exp1 =exp.negateExpression()
			expect(exp1.toLatexString()).to eq "-{((-2)+(-x))}"
			exp.setNegative(true); exp1 =exp.negateExpression()
			expect(exp1.toLatexString()).to eq "(-2)+(-x)"
		end
		it "getVariableList(): Full TermCoefficient, Operator, Full TermVariable, Term, TermFraction & Expression Exponent: should say '2^{2}+x^{2}' when we use TermCoefficient.new(2^{2}), Operator.new("+"), TermCoefficient.new(x^{2}) and toLatexString() method" do
			exp = Expression.new()
			termVar = TermVariable.new("x")
			termVar.setExponent(2)
			termCoeff = TermCoefficient.new(2)
			termCoeff.setExponent(2)
			term= Term.new()
			term.termItemList = [TermVariable.new("y"),termCoeff]
			term2= Term.new()
			term2.termItemList = [TermVariable.new("x"),termCoeff]
			termFraction= TermFraction.new(-3,4)
			termFraction.setExponent(2)
			exp.expressionItemList = [termCoeff,Operator.new("+"),termFraction]
			expect(exp.toLatexString()).to eq "2^{2}+{(\\frac{-3}{4})}^{2}"
			expect(exp.getVariableList().join(",").to_s).to eq ""
			exp.expressionItemList = [termVar]
			expect(exp.toLatexString()).to eq "x^{2}"
			expect(exp.getVariableList().join(",").to_s).to eq "x"
			exp.expressionItemList = [term2,Operator.new("-"),term]
			expect(exp.toLatexString()).to eq "2^{2}x-2^{2}y"
			expect(exp.getVariableList().join(",").to_s).to eq "x,y"
			exp.expressionItemList = [term2,Operator.new("-"),term2]
			expect(exp.toLatexString()).to eq "2^{2}x-2^{2}x"
			expect(exp.getVariableList().join(",").to_s).to eq "x"
			exp.expressionItemList = [termCoeff,Operator.new("+"),termVar,Operator.new("-"),term2,Operator.new("\\div"),termFraction]
			expect(exp.toLatexString()).to eq "2^{2}+x^{2}-2^{2}x\\div{(\\frac{-3}{4})}^{2}"
			expect(exp.getVariableList().join(",").to_s).to eq "x"
		end
	end
end