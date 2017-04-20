require_relative '../ui_math/TermFraction'
class RationalNumber
	attr_accessor :latexStringList
	def initialize()
		latexStringList=[]
	end
	def solveLinearEqWithVariableOnLeftSide(a,b,c,d,e,f,x,Op)
		#Variable Initiation
		var=TermVariable.new(x)
		termItem1 = TermFraction.new(a,b)
		termItem2 = TermFraction.new(c,d)
		termItem3 = TermFraction.new(e,f)
		op = Operator.new(Op)
		#If denominator is 1, remove denominator
		termItem1 = termItem1.reduceDenominator()
		termItem2 = termItem2.reduceDenominator()
		termItem3 = termItem3.reduceDenominator()
		termItem2Clone = termItem2.cloneOperation()
		term1 = Term.new()
		term1.termItemList = [termItem1,var]
		#If coefficient base is 1, 
		term1 = term1.reduceTerm()
		#If termItem2 is 0, then transposing termItem2 is not needed
		if termItem2.finalCalcValue() != 0
			latexStringList << (term1.toLatexString()+op.toLatexString()+termItem2.toLatexString()+"="+termItem3.toLatexString())
			latexStringList << "Transposing "+termItem2.toLatexString()+"to RHS"
			op1=op.opposite()
			latexStringList << (term1.toLatexString()+"="+termItem3.toLatexString()+op1.toLatexString()+termItem2.toLatexString())
			termItem2 = termItem3.operate(termItem2,op1)
			termItem2 = termItem2.simplify()
			latexStringList << (term1.toLatexString()+"="+termItem2.toLatexString())
		end
		

		#If term1[0] is not 1, equation is unsolved
		if term1[0].finalCalcValue()!=1
			if term1[0].baseDenominator.base==1
				latexStringList << "Dividing both sides by "+term1[0].toLatexString()+"to RHS" 
			elsif term1[0].baseNumerator.base==1
				latexStringList << "Multiplying both sides by "+term1[0].baseDenominator.toLatexString()+"to RHS" 
			else
				latexStringList << "Transposing "+term1[0].toLatexString()+"to RHS" 
			end

			latexStringList << var.toLatexStringList + "=" + termItem2.divideLatex(term1[0])
			termItem2 = termItem2.divide(term1[0])
			latexStringList << var.toLatexStringList + "=" + termItem2.toLatexString()
		end
		solution = termItem2
		latexStringList << "Required Solution "
		termItem1b = TermFraction.new(1,1)
		term1[1] = termItem1b.convertTermVariable(var,solution.numerator(),solution.denominator())
		latexStringFinal = "To check the answer: LHS ="+term1.toLatexString()+op.toLatexString()+termItem2Clone.toLatexString()
		term1=term1.simplify()
		latexStringFinal += "= "+term1.toLatexString()+op.toLatexString()+termItem2Clone.toLatexString()
		term1[0] = term1[0].operate(termItem2Clone,op)
		latexStringFinal += "= "+term1.toLatexString()+"= RHS (as required)"
		latexStringList << latexStringFinal
		return latexStringList
	end
	def solveLinearEqWithVariableOnBothSides(a,b,c,d,e,f,g,h,x,Op1,Op2)
		var=TermVariable.new(x)
		termItem1 = TermFraction.new(a,b)
		termItem2 = TermFraction.new(c,d)
		termItem3 = TermFraction.new(e,f)
		termItem4 = TermFraction.new(g,h)
		op1 = Operator.new(Op1)
		op2 = Operator.new(Op2)
		#If denominator is 1, remove denominator
		termItem1 = termItem1.reduceDenominator()
		termItem2 = termItem2.reduceDenominator()
		termItem3 = termItem3.reduceDenominator()
		termItem2Clone = termItem2.cloneOperation()
		term1 = Term.new()
		term1.termItemList = [termItem1,var]
		term3 = Term.new()
		term3.termItemList = [termItem3,var]
		#If coefficient base is 1, 
		term1 = term1.reduceTerm()
		term3 = term3.reduceTerm()

		#If termItem2 is 0, then transposing termItem2 is not needed
		if termItem2.finalCalcValue() != 0
			latexStringList << (term1.toLatexString()+op.toLatexString()+termItem2.toLatexString()+"="+term3.toLatexString()+op2.toLatexString()+termItem4.toLatexString())
			latexStringList << "Transposing "+term3.toLatexString()+"to LHS"
			op2=op2.opposite()
			latexStringList << (term1.toLatexString()+op1.toLatexString()+termItem2.toLatexString()+op2.toLatexString()+term3.toLatexString() + "="+term3.toLatexString())
			latexStringList << (var.toLatexString()+"("+term1[0]+op2.toLatexString()+term3[0].toLatexString()+")"+op1.toLatexString()+termItem2.toLatexString() + "="+term3.toLatexString())
			latexStringList << (var.toLatexString()+"("+term1[0].operateDisplay(term3[0],op)+")"+op1.toLatexString()+termItem2.toLatexString() + "="+term3.toLatexString())
			term1[0] = term1[0].operate(term3[0],op)
			latexStringList << (term1.toLatexString()+op1.toLatexString()+termItem2.toLatexString() + "="+term3.toLatexString())
			
		end
		latexStringList.concat(solveLinearEqWithVariableOnLeftSide)(term1[0].numerator(),term1[0].denominator(),termItem2.numerator(),termItem2.numerator(),termItem4.numerator(),termItem4.denominator())
		
	end
	def equivalentRationalNumber(a,b,c,numeratorFlag)
		# if NumeratorFlag, then input at numerator is asked
		mult = c/a
		mult = c/b if numeratorFlag
		termItema = TermCoefficient.new(a)
		termItemb = TermCoefficient.new(b)
		termItemc = TermCoefficient.new(c)
		termItemMult = TermCoefficient.new(mult)
		termItema.simplify()
		termItemb.simplify()
		termItemc.simplify()
		termItemMult.simplify()
		frac1=Fraction.new(termItema,termItemb)
		exp1 = Expression.new()
		exp1.expressionItemList = [termItema,Operator.new("\\times"),termItemMult,Operator.new("="),termItemc]
		exp1.expressionItemList[0] = termItemb if numeratorFlag
		exp2 = Expression.new()
		exp2.expressionItemList = [termItema,Operator.new("\\times"),termItemMult]
		exp3 = Expression.new()
		exp3.expressionItemList = [termItemb,Operator.new("\\times"),termItemMult]
		termItemaEquiv = TermCoefficient.new(a*mult)
		termItemaEquiv.simplify()
		termItembEquiv = TermCoefficient.new(b*mult)
		termItembEquiv.simplify()
		latexStringList << "We know "+exp1.toLatexString()
		latexStringList << "This means we need to multiply both the numerator and denominator by "+ termItemMult.toLatexString() +"to get the equivalent fraction"
		latexStringList << "Hence "
		latexStringList << frac1.toLatexString()+ Operator.new("=").toLatexString()+ Fraction.new(exp2,exp3).tolatexString()
		latexStringList << frac1.toLatexString()+ Operator.new("=").toLatexString() + Fraction.new(termItemaEquiv,termItembEquiv).tolatexString()
		latexStringList << Fraction.new(termItemaEquiv,termItembEquiv).tolatexString()+" is required equivalent fraction"

	end
	def equivalentRationalNumberSmall(a,b,requiredDen)
		# if NumeratorFlag, then input at numerator is asked
		multiplier = requiredDen/b
		frac = Fraction.new(a,b)
		numExp = Expression.new()
		denExp = Expression.new()
		numExp.expressionItemList=[frac.baseNumerator,Operator.new("\\times"),multiplier]
		denExp.expressionItemList=[frac.baseDenominator,Operator.new("\\times"),multiplier]
		equiFrac = Fraction.new(a*multiplier,b*multiplier)
		exp = Expression.new()
		exp.expressionItemList=[frac,Operator.new("="),Fraction.new(exp1,exp2),Operator.new("="),equiFrac]
		latexStringList << exp.toLatexString()
	end
	def simplestFrom(a,b)
		frac = Fraction.new(a,b)
		termItema = TermCoefficient.new(a)
		termItemb = TermCoefficient.new(b)
		termItema.simplify()
		termItemb.simplify()

		termItemgcd = TermCoefficient.new(gcd(a.abs,b.abs))
		termItemgcd.negative = true if b<0
		exp1 = Expression.new()
		exp1.expressionItemList = [termItema,Operator.new("\\div"),termItemgcd]
		exp2 = Expression.new()
		exp2.expressionItemList = [termItemb,Operator.new("\\div"),termItemgcd]
		termItemaEquiv = TermCoefficient.new(a/termItemgcd.base)
		termItemaEquiv.simplify()
		termItembEquiv = TermCoefficient.new(b/termItemgcd.base)
		termItembEquiv.simplify()
		latexStringList << "Shortest way to find equivalent fraction in simplest form is to find HCF of numerator and denominator and divide them by HCF"
		latexStringList << "HCF of "+termItema.toLatexString()+" and "+termItemb.toLatexString() +" is "+termItemgcd.toLatexString()
		latexStringList << frac.toLatexString() + Operator.new("=").toLatexString()+ Fraction.new(exp1,exp2)
		latexStringList << frac.toLatexString() + Operator.new("=").toLatexString()+ Fraction.new(termItemaEquiv,termItembEquiv)
		latexStringList << "The fraction "+Fraction.new(termItemaEquiv,termItembEquiv) 
	end
	def simplestFromSmall(a,b)
		frac = Fraction.new(a,b)
		frac.simplifyItemNegative()
		termItemgcd = TermCoefficient.new(gcd(a.abs,b.abs))
		termItemgcd.negative = true if b<0
		exp1 = [frac.baseNumerator,Operator.new("\\div"),termItemgcd]
		exp2 = [frac.baseDenominator,Operator.new("\\div"),termItemgcd]
		frac1 = Fraction.new(exp1,exp2)
		frac2 = Fraction.new(frac.baseNumerator.divide(termItemgcd),frac.baseDenominator.divide(termItemgcd))
		latexStringList << "We know that"+ frac.toLatexString()+frac1.toLatexString()+frac2.toLatexString()
	end
	def gcd(a, b)
	 	b == 0 ? a : gcd(b, a.modulo(b))
	end
	def negativeFlag(a,b)
		frac = Fraction.new(a,b)
		frac.simplifyItemNegative()
		if frac.baseNumerator.negative && !frac.baseNumerator.negative
			latexStringList << "The numerator of "+frac.toLatexString()+" is a negative integer, whereas the denominator is a positive integer. Such a rational number is called a negative rational number."
		elsif !frac.baseNumerator.negative && !frac.baseNumerator.negative
			latexStringList << "Both the numerator and denominator of this number are positive integers. Such a rational number is called a positive rational number"
		else
			exp1 = [frac.baseNumerator,Operator.new("\\times"),TermCoefficient.new(-1)]
			exp2 = [frac.baseDenominator,Operator.new("\\times"),TermCoefficient.new(-1)]
			frac1 = Fraction.new(exp1,exp2)
			frac2 = Fraction.new(frac.baseNumerator.negateTermItem(),frac.baseDenominator.negateTermItem())
			latexStringList << "We know that"+ frac.toLatexString()+frac1.toLatexString()+frac2.toLatexString()
			negativeFlag(frac2.baseNumerator,frac2.baseDenominator)
		end
	end
	def compare(a,b,c,d)
		frac1 = Fraction.new(a,b)
		frac2 = Fraction.new(c,d)
		simplestFromSmall(a,b)
		simplestFromSmall(c,d)
		frac1.reduce()
		frac2.reduce()
		if !frac1.negative && !frac2.negative
			compareFraction(frac1.baseNumerator,frac1.baseDenominator,frac2.baseNumerator,frac2.baseDenominator)
		elsif frac1.negative && frac1.negative
			frac3 = frac1.negateTermItem()
			frac4 = frac2.negateTermItem()
			compareFraction(frac3.baseNumerator,frac3.baseDenominator,frac4.baseNumerator,frac4.baseDenominator)
		elsif frac1.negative
			latexStringList<< "Comparison of a negative and a positive rational number is obvious. A negative rational number is to the left of zero whereas a positive rational number is to the right of zero on a number line. So, a negative rational number will always be less than a positive rational number."
			latexStringList<< frac1.toLatexString() + Operator.new("<")+ frac2.toLatexString()
		else
			latexStringList<< "Comparison of a negative and a positive rational number is obvious. A negative rational number is to the left of zero whereas a positive rational number is to the right of zero on a number line. So, a negative rational number will always be less than a positive rational number."
			latexStringList<< frac2.toLatexString() + Operator.new("<")+ frac1.toLatexString()
		end

	end

	def compareFraction(a,b,c,d)
		frac1 = Fraction.new(a,b)
		frac2 = Fraction.new(c,d)
		if frac1> frac2
			higherFrac = frac1
			lowerFrac = frac2
		else
			higherFrac = frac2
			lowerFrac = frac1
		end
		if frac1 == frac2
			latexStringList << "Both are equal fractions."
			latexStringList << higherFrac.toLatexString() + Operator.new("=")+ lowerFrac.toLatexString()
		elsif frac1.baseDenominator.equals(frac2.baseDenominator)
			latexStringList << "Both are like fraction."
			latexStringList << "In both the fractions the whole is divided into "+frac1.baseDenominator+" equal parts. For we take "+frac1.baseNumerator+" and "+frac2.baseNumerator+" parts respectively out of the "+frac1.baseDenominator+" equal parts. "
			latexStringList << "Clearly, out of "+frac1.baseDenominator+" equal parts, the portion corresponding to "+higherFrac.baseNumerator+" parts is larger than the portion corresponding to "+lowerFrac.baseNumerator+" parts."
			latexStringList << higherFrac.toLatexString() + Operator.new(">")+ lowerFrac.toLatexString()
		elsif if frac1.baseNumerator.equals (frac2.baseNumerator)
			latexStringList << "Both are unlike fractions with same numerator."
			latexStringList << "In "+frac1.toLatexString()+", we divide the whole into "+frac1.baseDenominator+" equal parts and take "+frac1.baseNumerator+" parts. In"+frac2.toLatexString()+", we divide the whole into "+frac2.baseDenominator+" equal parts and take "+frac2.baseNumerator+" part."
			latexStringList << "Note that in"+higherFrac.toLatexString()+" , the whole is divided into a smaller number of parts than in "+lowerFrac.toLatexString()
			latexStringList << "Therefore, each equal part of the whole in case of"+higherFrac.toLatexString()+" is larger than that in case of "+lowerFrac.toLatexString()
			latexStringList << higherFrac.toLatexString() + Operator.new(">")+ lowerFrac.toLatexString()
		else 
			latexStringList << "The fractions are unlike. We should first get their equivalent fractions with a denominator which is a LCM of "+frac1.baseDenominator+" and "+frac2.baseDenominator+"."
			lcm = frac1.lcmDenominator(frac2)
			equivalentRationalNumberSmall(a,b,lcm.base)
			equivalentRationalNumberSmall(c,d,lcm.base)
			compareFraction(a*lcm.base,b*lcm.base,c*lcm.base,d*lcm.base)
			latexStringList << higherFrac.toLatexString() + Operator.new(">")+ lowerFrac.toLatexString()
		end

	end
	def addFraction(a,b,c,d)
		frac1 = Fraction.new(a,b)
		frac2 = Fraction.new(c,d)
		if frac1.baseDenominator.equals(frac2.baseDenominator)
			latexStringList << "Both are like fraction.The sum of two or more like fractions can be obtained as follows"
			latexStringList << "Retain the (common) denominator and add the numerators"
			numExp = Expression.new()
			numExp.expressionItemList = [frac1.baseNumerator+Operator.new("+")+frac2.baseNumerator]
			exp = Expression.new()
			exp.expressionItemList = [frac1,Operator.new("+"),frac2,Operator.new("="),Fraction.new(numExp,frac1.baseDenominator),Operator.new("="),frac1.add(frac2)]
			latexStringList << exp.toLatexString()
		else
			latexStringList << "The fractions are unlike. We should first get their equivalent fractions with a denominator which is a LCM of "+frac1.baseDenominator+" and "+frac2.baseDenominator+"."
			lcm = frac1.lcmDenominator(frac2)
			equivalentRationalNumberSmall(a,b,lcm.base,true)
			equivalentRationalNumberSmall(c,d,lcm.base,true)
			addFraction(a*lcm.base,b*lcm.base,c*lcm.base,d*lcm.base)
		end

	end
	def subtractFraction(a,b,c,d)
		frac1 = Fraction.new(a,b)
		frac2 = Fraction.new(c,d)
		if frac1.baseDenominator.equals(frac2.baseDenominator)
			latexStringList << "Both are like fraction.The difference of two like fractions can be obtained as follows"
			latexStringList << "Retain the (common) denominator and subtract the numerators"
			numExp = Expression.new()
			numExp.expressionItemList = [frac1.baseNumerator+Operator.new("-")+frac2.baseNumerator]
			exp = Expression.new()
			exp.expressionItemList = [frac1,Operator.new("-"),frac2,Operator.new("="),Fraction.new(numExp,frac1.baseDenominator),Operator.new("="),frac1.subtract(frac2)]
			latexStringList << exp.toLatexString()
		else
			latexStringList << "The fractions are unlike. We should first get their equivalent fractions with a denominator which is a LCM of "+frac1.baseDenominator+" and "+frac2.baseDenominator+"."
			lcm = frac1.lcmDenominator(frac2)
			equivalentRationalNumberSmall(a,b,lcm.base,true)
			equivalentRationalNumberSmall(c,d,lcm.base,true)
			subtractFraction(a*lcm.base,b*lcm.base,c*lcm.base,d*lcm.base)
		end

	end
	def additiveInverse(a,b)
		frac = Fraction.new(a,b)
		negativeFrac = frac.negateTermItem()
		numExp = Expression.new()
		numExp.expressionItemList = [frac.baseNumerator,Operator.new("+"),negativeFrac.baseNumerator]
		finalExp = Expression.new()
		finalExp.expressionItemList = [frac1,Operator.new("+"),negativeFrac,Operator.new("="),Fraction.new(numExp,frac.baseDenominator),Operator.new("="),frac.add(negativeFrac),Operator.new("="),TermCoefficient.new(0)]
		latexStringList << finalExp.toLatexString()
	end
	def multiplicativeInverse(a,b)
		frac = Fraction.new(a,b)
		reciprocalFrac = frac.reciprocal()
		exp = Expression.new()
		exp.expressionItemList = [frac,Operator.new("\\times"),reciprocalFrac,Operator.new("="),TermCoefficient.new(1)]
		latexStringList << frac.toLatexString()+"must be multiplied by"+reciprocalFrac.toLatexString()+"so as to get product 1 because "+exp.toLatexString()
	end
end