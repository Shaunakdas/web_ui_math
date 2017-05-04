require_relative '../ui_math/TermFraction'

class RationalNumber
	attr_accessor :latexStringList
	def initialize()
		@latexStringList=[]
		commonOpInit()
	end
	def commonOpInit()
		puts "commonOpInit"
		@bracStart = Operator.new("(")
		@bracEnd = Operator.new(")")
		@curlyStart = Operator.new("{")
		@curlyEnd = Operator.new("}")
		@eq = Operator.new("=")
		@times = Operator.new("\\times")
		@div = Operator.new("\\div")
		@add = Operator.new("+")
		@subtract = Operator.new("-")
		@lt = Operator.new("<")
		@gt = Operator.new(">")
		@and = Operator.new("&")
		@sqrt = Operator.new("\\sqrt")
		@cbrt = Operator.new("\\cbrt")
	end
	def ratNum_checkForPrimitive(*args)
		item = args[0]
		if item.is_a?(Integer) || item.is_a?(Float)
			return true
		else
			return false
		end
	end
	def ratNum_getBase(*args)
		item = args[0]
		return item.base if !ratNum_checkForPrimitive(item)
		return item
	end
	def ratNum_solveLinearEqWithVariableOnLeftSide(*args)
		a=args[0];b=args[1];c=args[2];d=args[3];e=args[4];f=args[5];x=args[6];operator=args[7]
		puts "solveLinearEqWithVariableOnLeftSide"
		a=ratNum_getBase(a);b=ratNum_getBase(b);c=ratNum_getBase(c);d=ratNum_getBase(d);e=ratNum_getBase(e);f=ratNum_getBase(f)
		exp=Expression.new()
		#Variable Initiation
		var=TermVariable.new(x)
		termItem1 = TermFraction.new(a,b)
		termItem2 = TermFraction.new(c,d)
		termItem3 = TermFraction.new(e,f)
		op = Operator.new(operator)
		#If denominator is 1, remove denominator
		termItem1 = termItem1.reduceFormWithDen()
		termItem2 = termItem2.reduceFormWithDen()
		termItem3 = termItem3.reduceFormWithDen()
		termItem2Clone = termItem2.cloneForOperation()
		term1 = Term.new()
		term1.termItemList = [termItem1,var]
		#If coefficient base is 1, 
		term1.reduceTerm()
		
		#If termItem2 is 0, then transposing termItem2 is not needed
		if termItem2.calcFinalValue() != 0
			exp.expressionItemList=[term1,op,termItem2,@eq,termItem3]
			@latexStringList << exp.toLatexString()
			# @latexStringList << (term1.toLatexString()+op.toLatexString()+termItem2.toLatexString()+"="+termItem3.toLatexString())
			@latexStringList << "Transposing "+termItem2.toLatexString()+"to RHS"
			op1=op.opposite()
			exp.expressionItemList=[term1,@eq,termItem3,op1,termItem2]; @latexStringList << exp.toLatexString()
			# @latexStringList << (term1.toLatexString()+"="+termItem3.toLatexString()+op1.toLatexString()+termItem2.toLatexString())
			puts "Symbol minus"+op1.symbol
			termItem2 = termItem3.operate(op1,termItem2)
			termItem2.simplify()
			exp.expressionItemList=[term1,@eq,termItem2]
			@latexStringList << exp.toLatexString()
			# @latexStringList << (term1.toLatexString()+"="+termItem2.toLatexString())
		end
		

		#If term1[0] is not 1, equation is unsolved
		if term1[0].class.name == "TermFraction" && term1[0].calcFinalValue()!=1
			if term1[0].baseDenominator.base==1
				@latexStringList << "Dividing both sides by "+term1[0].toLatexString() 
				exp.expressionItemList=[var,@eq,termItem2.operateExpression(@div,term1[0])]; @latexStringList << exp.toLatexString()
			elsif term1[0].baseNumerator.base==1
				@latexStringList << "Multiplying both sides by "+term1[0].baseDenominator.toLatexString()
				exp.expressionItemList=[var,@eq,termItem2.operateExpression(@times,term1[0].baseDenominator)]; @latexStringList << exp.toLatexString()
			else
				@latexStringList << "Transposing "+term1[0].toLatexString()+"to RHS" 
				exp.expressionItemList=[var,@eq,termItem2.operateExpression(@div,term1[0])]; @latexStringList << exp.toLatexString()
			end
			
			# @latexStringList << var.toLatexString() + "=" + termItem2.operateExpression(term1[0])
			termItem2 = termItem2/term1[0]
			termItem2.simplify()
			exp.expressionItemList=[var,@eq,termItem2]; @latexStringList << exp.toLatexString()
			# @latexStringList << var.toLatexStringList + "=" + termItem2.toLatexString()
		end
		solution = termItem2
		puts "solution class"+solution.class.name
		@latexStringList << "Required Solution "
		termItem1b = TermFraction.new(1,1)
		term1[1] = termItem1b.convertTermVariable(var,solution.numerator(),solution.denominator())
		latexStringFinal = "To check the answer: LHS ="+term1.toLatexString()+op.toLatexString()+termItem2Clone.toLatexString()
		puts "95: TERM1b"+term1.toLatexString()
		term1.simplify()
		puts "97: TERM1b"+term1.toLatexString()
		latexStringFinal += "= "+term1.toLatexString()+op.toLatexString()+termItem2Clone.toLatexString()
		term1[0] = term1[0].operate(op,termItem2Clone)
		latexStringFinal += "= "+term1.toLatexString()+"= RHS (as required)"
		@latexStringList << latexStringFinal
		return @latexStringList
	end
	def ratNum_solveLinearEqWithVariableOnBothSides(*args)
		a=args[0];b=args[1];c=args[2];d=args[3];e=args[4];f=args[5];g=args[6];h=args[7];x=args[8];operator1=args[9];operator2=args[9]
		puts "solveLinearEqWithVariableOnBothSides"
		exp=Expression.new()
		var=TermVariable.new(x)
		termItem1 = TermFraction.new(a,b)
		termItem2 = TermFraction.new(c,d)
		termItem3 = TermFraction.new(e,f)
		termItem4 = TermFraction.new(g,h)
		op1 = Operator.new(operator1)
		op2 = Operator.new(operator2)
		#If denominator is 1, remove denominator
		termItem1 = termItem1.reduceFormWithDen()
		termItem2 = termItem2.reduceFormWithDen()
		termItem3 = termItem3.reduceFormWithDen()
		termItem4 = termItem4.reduceFormWithDen()
		termItem2Clone = termItem2.cloneForOperation()
		term1 = Term.new()
		term1.termItemList = [termItem1,var]
		term3 = Term.new()
		term3.termItemList = [termItem3,var]
		#If coefficient base is 1, 
		term1.reduceTerm()
		term3.reduceTerm()
		puts "term1.reduceTerm()"+term1.toLatexString()
		#If termItem2 is 0, then transposing termItem2 is not needed
		if termItem2.calcFinalValue() != 0
			exp.expressionItemList=[term1,op1,termItem2,@eq,term3,op2,termItem4]; @latexStringList << exp.toLatexString()
			# @latexStringList << (term1.toLatexString()+op.toLatexString()+termItem2.toLatexString()+"="+term3.toLatexString()+op2.toLatexString()+termItem4.toLatexString())
			@latexStringList << "Transposing "+term3.toLatexString()+"to LHS"
			op2=op2.opposite()

			exp.expressionItemList=[term1,op1,termItem2,op2,term3,@eq,termItem4]; @latexStringList << exp.toLatexString()
			# @latexStringList << (term1.toLatexString()+op1.toLatexString()+termItem2.toLatexString()+op2.toLatexString()+term3.toLatexString() + "="+term3.toLatexString())
			exp.expressionItemList=[var,@bracStart,term1[0],op2,term3[0],@bracEnd,op1,termItem2,@eq,termItem4]; @latexStringList << exp.toLatexString()
			# @latexStringList << (var.toLatexString()+"("+term1[0]+op2.toLatexString()+term3[0].toLatexString()+")"+op1.toLatexString()+termItem2.toLatexString() + "="+term3.toLatexString())
			exp.expressionItemList=[var,@bracStart,term1[0].operateExpression(op2,term3[0]),@bracEnd,op1,termItem2,@eq,termItem4]; @latexStringList << exp.toLatexString()
			# @latexStringList << (var.toLatexString()+"("+term1[0].operateDisplay(term3[0],op)+")"+op1.toLatexString()+termItem2.toLatexString() + "="+term3.toLatexString())
			term1[0] = term1[0].operate(op2,term3[0])
			exp.expressionItemList=[term1,op1,termItem2,@eq,term3]; @latexStringList << exp.toLatexString()
			# @latexStringList << (term1.toLatexString()+op1.toLatexString()+termItem2.toLatexString() + "="+term3.toLatexString())
			
		end
		puts "Term1[0]"+term1[0].toLatexString()
		puts "Term1[0]"+term1[0].class.name
		#Shifting negative sign inside the numerator
		term1[0] = term1[0].cloneForOperation()
		if term1[0].class.name == "TermCoefficient"
			a=term1[0];b=1
		else
			a=term1[0].numerator();b=term1[0].denominator()
		end
		if termItem2.class.name == "TermCoefficient"
			c=termItem2;c=1
		else
			c=termItem2.numerator();d=termItem2.denominator()
		end
		if termItem4.class.name == "TermCoefficient"
			e=termItem4;f=1
		else
			e=termItem4.numerator();f=termItem4.denominator()
		end
		ratNum_solveLinearEqWithVariableOnLeftSide(a,b,c,d,e,f,x,operator1)
		# ratNum_solveLinearEqWithVariableOnLeftSide(term1[0].numerator(),term1[0].denominator(),termItem2.numerator(),termItem2.numerator(),termItem4.numerator(),termItem4.denominator(),x,operator1)
		
	end
	def ratNum_equivalentRationalNumber(*args)
		a=args[0];b=args[1];c=args[2];numeratorFlag=args[3]
		puts "equivalentRationalNumber"
		exp=Expression.new()
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
		frac1= TermFraction.new(termItema,termItemb)
		exp1 = Expression.new()
		exp1.expressionItemList = [termItema,@times,termItemMult,@eq,termItemc]
		exp1.expressionItemList[0] = termItemb if numeratorFlag
		exp2 = Expression.new()
		exp2.expressionItemList = [termItema,@times,termItemMult]
		exp3 = Expression.new()
		exp3.expressionItemList = [termItemb,@times,termItemMult]
		termItemaEquiv = TermCoefficient.new(a*mult)
		termItemaEquiv.simplify()
		termItembEquiv = TermCoefficient.new(b*mult)
		termItembEquiv.simplify()
		@latexStringList << "We know "+exp1.toLatexString()
		@latexStringList << "This means we need to multiply both the numerator and denominator by "+ termItemMult.toLatexString() +"to get the equivalent fraction"
		@latexStringList << "Hence "
		exp.expressionItemList=[frac1,@eq,TermFraction.new(exp2,exp3)]; @latexStringList << exp.toLatexString()
		# @latexStringList << frac1.toLatexString()+ @eq.toLatexString()+ TermFraction.new(exp2,exp3).toLatexString()
		exp.expressionItemList=[frac1,@eq,TermFraction.new(termItemaEquiv,termItembEquiv)]; @latexStringList << exp.toLatexString()
		# @latexStringList << frac1.toLatexString()+ @eq.toLatexString() + TermFraction.new(termItemaEquiv,termItembEquiv).toLatexString()
		exp.expressionItemList=[TermFraction.new(termItemaEquiv,termItembEquiv)]; @latexStringList << exp.toLatexString()+" is required equivalent fraction"
		# @latexStringList << TermFraction.new(termItemaEquiv,termItembEquiv).toLatexString()+" is required equivalent fraction"

	end
	def ratNum_equivalentRationalNumberSmall(*args)
		puts "equivalentRationalNumberSmall"
		a=args[0];b=args[1];requiredDen=args[2]
		# if NumeratorFlag, then input at numerator is asked
		a=ratNum_getBase(a);b=ratNum_getBase(b);requiredDen=ratNum_getBase(requiredDen)
		a=a.base if !ratNum_checkForPrimitive(a)
		b=b.base if !ratNum_checkForPrimitive(b)
		requiredDen=requiredDen.base if !ratNum_checkForPrimitive(requiredDen)
		exp=Expression.new()
		multiplier = requiredDen/b
		puts "multiplier"+multiplier.to_s
		frac = TermFraction.new(a,b)
		numExp = Expression.new()
		denExp = Expression.new()
		numExp.expressionItemList=[frac.baseNumerator,@times,TermCoefficient.new(multiplier)]
		denExp.expressionItemList=[frac.baseDenominator,@times,TermCoefficient.new(multiplier)]
		equiFrac = TermFraction.new(a*multiplier,b*multiplier)
		exp = Expression.new()
		exp.expressionItemList=[frac,@eq,TermFraction.new(numExp,denExp),@eq,equiFrac]
		@latexStringList << exp.toLatexString()
	end
	def ratNum_simplestForm(*args)
		puts "ratNum_simplestForm"
		a=args[0];b=args[1]
		exp=Expression.new()
		displayExp = Expression.new()
		frac = TermFraction.new(a,b)
		termItema = TermCoefficient.new(a)
		termItemb = TermCoefficient.new(b)
		termItema.simplify()
		termItemb.simplify()

		termItemgcd = TermCoefficient.new(gcd(a.abs,b.abs))
		termItemgcd.negative = true if b<0
		exp1 = Expression.new()
		exp1.expressionItemList = [termItema,@div,termItemgcd]
		exp2 = Expression.new()
		exp2.expressionItemList = [termItemb,@div,termItemgcd]
		termItemaEquiv = TermCoefficient.new(a/termItemgcd.base)
		termItemaEquiv.simplify()
		termItembEquiv = TermCoefficient.new(b/termItemgcd.base)
		termItembEquiv.simplify()
		@latexStringList << "Shortest way to find equivalent fraction in simplest form is to find HCF of numerator and denominator and divide them by HCF"
		@latexStringList << "HCF of "+termItema.toLatexString()+" and "+termItemb.toLatexString() +" is "+termItemgcd.toLatexString()
		displayExp.expressionItemList=[frac]
		exp.expressionItemList=[frac,@eq,TermFraction.new(exp1,exp2)]; @latexStringList << displayExp.toLatexString()
		# @latexStringList << frac.toLatexString() + @eq.toLatexString()+ TermFraction.new(exp1,exp2).toLatexString()
		exp.expressionItemList=[frac,@eq,TermFraction.new(termItemaEquiv,termItembEquiv)]; @latexStringList << exp.toLatexString()
		# @latexStringList << frac.toLatexString() + @eq.toLatexString()+ TermFraction.new(termItemaEquiv,termItembEquiv).toLatexString()
		@latexStringList << "The fraction "+TermFraction.new(termItemaEquiv,termItembEquiv).toLatexString()
	end
	def ratNum_simplestFormSmall(*args)
		puts "ratNum_simplestFormSmall"
		a=args[0];b=args[1]
		exp=Expression.new();exp1=Expression.new();exp2=Expression.new()
		frac = TermFraction.new(a,b)
		frac.simplifyItemNegative()
		termItemgcd = TermCoefficient.new(gcd(a.abs,b.abs))
		termItemgcd.negative = true if b<0
		exp1.expressionItemList  = [frac.baseNumerator,@div,termItemgcd]
		exp2.expressionItemList  = [frac.baseDenominator,@div,termItemgcd]
		frac1 = TermFraction.new(exp1,exp2)
		frac2 = TermFraction.new(frac.baseNumerator.divide(termItemgcd),frac.baseDenominator.divide(termItemgcd))
		exp.expressionItemList=[frac,@eq,frac1,@eq,frac2]; @latexStringList << exp.toLatexString()
		# @latexStringList <<  frac.toLatexString()+frac1.toLatexString()+frac2.toLatexString()
	end
	def gcd(a, b)
		puts "gcd"
	 	b == 0 ? a : gcd(b, a.modulo(b))
	end
	def ratNum_negativeFlag(*args)
		puts "negativeFlag"
		a=args[0];b=args[1]
		exp=Expression.new();exp1=Expression.new();exp2=Expression.new()
		frac = TermFraction.new(a,b)
		frac.simplifyItemNegative()
		if frac.baseNumerator.negative && !frac.baseNumerator.negative
			@latexStringList << "The numerator of "+frac.toLatexString()+" is a negative integer, whereas the denominator is a positive integer. Such a rational number is called a negative rational number."
		elsif !frac.baseNumerator.negative && !frac.baseNumerator.negative
			@latexStringList << "Both the numerator and denominator of this number are positive integers. Such a rational number is called a positive rational number"
		else
			exp1.expressionItemList = [frac.baseNumerator,@times,TermCoefficient.new(-1)]
			exp2.expressionItemList  = [frac.baseDenominator,@times,TermCoefficient.new(-1)]
			frac1 = TermFraction.new(exp1,exp2)
			frac2 = TermFraction.new(frac.baseNumerator.negateTermItem(),frac.baseDenominator.negateTermItem())
			exp.expressionItemList=[frac,@eq,frac1,@eq,frac2]; @latexStringList << "We know that"+exp.toLatexString()
			# @latexStringList << "We know that"+ frac.toLatexString()+frac1.toLatexString()+frac2.toLatexString()
			negativeFlag(frac2.baseNumerator,frac2.baseDenominator)
		end
	end
	def ratNum_compare(*args)
		puts "compare"
		a=args[0];b=args[1];c=args[2];d=args[3]
		exp=Expression.new()
		frac1 = TermFraction.new(a,b)
		frac2 = TermFraction.new(c,d)
		ratNum_simplestFormSmall(a,b)
		ratNum_simplestFormSmall(c,d)
		frac1.reduce()
		frac2.reduce()
		if !frac1.negative && !frac2.negative
			ratNum_compareFraction(frac1.baseNumerator,frac1.baseDenominator,frac2.baseNumerator,frac2.baseDenominator)
		elsif frac1.negative && frac1.negative
			frac3 = frac1.negateTermItem()
			frac4 = frac2.negateTermItem()
			ratNum_compareFraction(frac3.baseNumerator,frac3.baseDenominator,frac4.baseNumerator,frac4.baseDenominator)
		elsif frac1.negative
			@latexStringList<< "Comparison of a negative and a positive rational number is obvious. A negative rational number is to the left of zero whereas a positive rational number is to the right of zero on a number line. So, a negative rational number will always be less than a positive rational number."
			exp.expressionItemList=[frac1,@lt,frac2]; @latexStringList << exp.toLatexString()
			# @latexStringList<< frac1.toLatexString() + @lt+ frac2.toLatexString()
		else
			@latexStringList<< "Comparison of a negative and a positive rational number is obvious. A negative rational number is to the left of zero whereas a positive rational number is to the right of zero on a number line. So, a negative rational number will always be less than a positive rational number."
			exp.expressionItemList=[frac2,@lt,frac2]; @latexStringList << exp.toLatexString()
			# @latexStringList<< frac2.toLatexString() + @lt+ frac1.toLatexString()
		end

	end

	def ratNum_compareFraction(*args)
		puts "ratNum_compareFraction"
		a=args[0];b=args[1];c=args[2];d=args[3]
		exp=Expression.new()
		frac1 = TermFraction.new(a,b)
		frac2 = TermFraction.new(c,d)
		if frac1> frac2
			higherFrac = frac1
			lowerFrac = frac2
		else
			higherFrac = frac2
			lowerFrac = frac1
		end
		if frac1 == frac2
			@latexStringList << "Both are equal fractions."
			exp.expressionItemList=[higherFrac,@eq,lowerFrac]; @latexStringList << exp.toLatexString()
			# @latexStringList << higherFrac.toLatexString() + @eq+ lowerFrac.toLatexString()
		elsif frac1.baseDenominator == (frac2.baseDenominator)
			@latexStringList << "Both are like fraction."
			@latexStringList << "In both the fractions the whole is divided into "+frac1.baseDenominator.toLatexString()+" equal parts. For we take "+frac1.baseNumerator.toLatexString()+" and "+frac2.baseNumerator.toLatexString()+" parts respectively out of the "+frac1.baseDenominator.toLatexString()+" equal parts. "
			@latexStringList << "Clearly, out of "+frac1.baseDenominator.toLatexString()+" equal parts, the portion corresponding to "+higherFrac.baseNumerator.toLatexString()+" parts is larger than the portion corresponding to "+lowerFrac.baseNumerator.toLatexString()+" parts."
			exp.expressionItemList=[higherFrac,@gt,lowerFrac]; @latexStringList << exp.toLatexString()
			# @latexStringList << higherFrac.toLatexString() + @gt+ lowerFrac.toLatexString()
		elsif frac1.baseNumerator == (frac2.baseNumerator)
			@latexStringList << "Both are unlike fractions with same numerator."
			@latexStringList << "In "+frac1.toLatexString()+", we divide the whole into "+frac1.baseDenominator.toLatexString()+" equal parts and take "+frac1.baseNumerator.toLatexString()+" parts. In"+frac2.toLatexString()+", we divide the whole into "+frac2.baseDenominator.toLatexString()+" equal parts and take "+frac2.baseNumerator.toLatexString()+" part."
			@latexStringList << "Note that in"+higherFrac.toLatexString()+" , the whole is divided into a smaller number of parts than in "+lowerFrac.toLatexString()
			@latexStringList << "Therefore, each equal part of the whole in case of"+higherFrac.toLatexString()+" is larger than that in case of "+lowerFrac.toLatexString()
			exp.expressionItemList=[higherFrac,@gt,lowerFrac]; @latexStringList << exp.toLatexString()
			# @latexStringList << higherFrac.toLatexString() + @gt+ lowerFrac.toLatexString()
		else 
			@latexStringList << "The fractions are unlike. We should first get their equivalent fractions with a denominator which is a LCM of "+frac1.baseDenominator.toLatexString()+" and "+frac2.baseDenominator.toLatexString()+"."
			lcm = frac1.lcmDenominator(frac2)
			a=ratNum_getBase(a);b=ratNum_getBase(b);c=ratNum_getBase(c);d=ratNum_getBase(d);lcm=ratNum_getBase(lcm)
			ratNum_equivalentRationalNumberSmall(a,b,lcm)
			ratNum_equivalentRationalNumberSmall(c,d,lcm)
			ratNum_compareFraction(a*lcm/b,lcm,c*lcm/d,lcm)
			exp.expressionItemList=[higherFrac,@gt,lowerFrac]; @latexStringList << exp.toLatexString()
			# @latexStringList << higherFrac.toLatexString() + @gt+ lowerFrac.toLatexString()
		end

	end
	def ratNum_addFraction(*args)
		puts "ratNum_addFraction"
		a=args[0];b=args[1];c=args[2];d=args[3]
		exp=Expression.new()
		frac1 = TermFraction.new(a,b)
		frac2 = TermFraction.new(c,d)
		if frac1.baseDenominator==(frac2.baseDenominator)
			@latexStringList << "Both are like fraction.The sum of two or more like fractions can be obtained as follows"
			@latexStringList << "Retain the (common) denominator and add the numerators"
			numExp = Expression.new()
			numExp.expressionItemList = [frac1.baseNumerator,@add,frac2.baseNumerator]
			exp = Expression.new()
			exp.expressionItemList = [frac1,@add,frac2,@eq,TermFraction.new(numExp,frac1.baseDenominator),@eq,frac1.add(frac2)]
			@latexStringList << exp.toLatexString()
		else
			@latexStringList << "The fractions are unlike. We should first get their equivalent fractions with a denominator which is a LCM of "+frac1.baseDenominator.toLatexString()+" and "+frac2.baseDenominator.toLatexString()+"."
			lcm = frac1.lcmDenominator(frac2)
			a=ratNum_getBase(a);b=ratNum_getBase(b);c=ratNum_getBase(c);d=ratNum_getBase(d);lcm=ratNum_getBase(lcm)
			ratNum_equivalentRationalNumberSmall(a,b,lcm)
			ratNum_equivalentRationalNumberSmall(c,d,lcm)
			ratNum_addFraction(a*lcm/b,lcm,c*lcm/d,lcm)
		end

	end
	def ratNum_subtractFraction(*args)
		puts "ratNum_subtractFraction"
		a=args[0];b=args[1];c=args[2];d=args[3]
		exp=Expression.new()
		frac1 = TermFraction.new(a,b)
		frac2 = TermFraction.new(c,d)
		if frac1.baseDenominator == (frac2.baseDenominator)
			@latexStringList << "Both are like fraction.The difference of two like fractions can be obtained as follows"
			@latexStringList << "Retain the (common) denominator and subtract the numerators"
			numExp = Expression.new()
			numExp.expressionItemList = [frac1.baseNumerator,@subtract,frac2.baseNumerator]
			exp = Expression.new()
			exp.expressionItemList = [frac1,@subtract,frac2,@eq,TermFraction.new(numExp,frac1.baseDenominator),@eq,frac1.add(frac2.negateTermItem())]
			@latexStringList << exp.toLatexString()
		else
			@latexStringList << "The fractions are unlike. We should first get their equivalent fractions with a denominator which is a LCM of "+frac1.baseDenominator.toLatexString()+" and "+frac2.baseDenominator.toLatexString()+"."
			lcm = frac1.lcmDenominator(frac2)
			a=ratNum_getBase(a);b=ratNum_getBase(b);c=ratNum_getBase(c);d=ratNum_getBase(d);lcm=ratNum_getBase(lcm)
			ratNum_equivalentRationalNumberSmall(a,b,lcm)
			ratNum_equivalentRationalNumberSmall(c,d,lcm)
			ratNum_subtractFraction(a*lcm/b,lcm,c*lcm/d,lcm)
		end

	end
	def ratNum_additiveInverse(*args)
		puts "ratNum_additiveInverse"
		a=args[0];b=args[1]
		exp=Expression.new()
		frac = TermFraction.new(a,b)
		negativeFrac = frac.negateTermItem()
		numExp = Expression.new()
		numExp.expressionItemList = [frac.baseNumerator,@add,negativeFrac.baseNumerator]
		finalExp = Expression.new()
		finalExp.expressionItemList = [frac,@add,negativeFrac,@eq,TermFraction.new(numExp,frac.baseDenominator),@eq,frac.add(negativeFrac),@eq,TermCoefficient.new(0)]
		@latexStringList << finalExp.toLatexString()
	end
	def ratNum_multiplicativeInverse(*args)
		puts "ratNum_multiplicativeInverse"
		a=args[0];b=args[1]
		exp=Expression.new()
		frac = TermFraction.new(a,b)
		reciprocalFrac = frac.reciprocal()
		exp.expressionItemList = [frac,@times,reciprocalFrac,@eq,TermCoefficient.new(1)]
		@latexStringList << frac.toLatexString()+"must be multiplied by"+reciprocalFrac.toLatexString()+"so as to get product 1 because "+exp.toLatexString()
	end
end