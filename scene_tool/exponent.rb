require_relative '../ui_math/TermFraction'
require 'prime'
class Exponent
	attr_accessor :latexStringList
	def initialize()
		@latexStringList=[]
		commonOpInit()
	end
	def commonOpInit()
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
	def exp_expressPower(*args)
		value = args[0]; base = args[1]; exponent = Math.log(value,base)	
		coeffValue = TermCoefficient.new(value); coeffBase = TermCoefficient.new(base); coeffExpo = TermCoefficient.new(exponent)
		displayExp = Expression.new()
		displayExp.expressionItemList = [coeffValue,@eq]
		for i in 1..exponent
			displayExp.expressionItemList << @times if i!=1
			displayExp.expressionItemList << coeffBase
		end
		latexStringList << displayExp.toLatexString()
		coeffBase.setExponent(exponent)
		displayExp.expressionItemList = [coeffValue,@eq,coeffBase]
		latexStringList << "We can say that "+displayExp.toLatexString()
	end
	def exp_calExponent(*args)
		base = args[0]; exponent = args[1]; value = base**exponent
		coeffValue = TermCoefficient.new(value); coeffBase = TermCoefficient.new(base); coeffExpo = TermCoefficient.new(exponent)
		displayExp = Expression.new()
		coeffBase.setExponent(exponent)
		displayExp.expressionItemList = [coeffBase,@eq]
		for i in 1..exponent
			displayExp.expressionItemList << @times if i!=1
			displayExp.expressionItemList << TermCoefficient.new(base)
		end
		displayExp.expressionItemList.concat([@eq,coeffValue])
		latexStringList << displayExp.toLatexString()
	end
	def exp_squareOneDigit(*args)
		a=args[0]
		oneDigit = a%10
		if oneDigit==1 || oneDigit==9
			@latexStringList << "if a number has "+oneDigit.to_s+" in the unit’s place, then it’s square ends in 1."
		elsif oneDigit==4 || oneDigit==6
			@latexStringList << "if a number has "+oneDigit.to_s+" in the unit’s place, then it’s square ends in 6."
		elsif oneDigit==5
			@latexStringList << "if a number has "+oneDigit.to_s+" in the unit’s place, then it’s square ends in 5."
		end
	end
	def exp_squareValue(*args)
		a=args[0]
		termItem = TermCoefficient.new(a)
		squareItem = termItem.cloneForOperation()
		squareItem.setExponent(2)
		exp = Expression.new()
		exp.expressionItemList = [squareItem,@eq,termItem,@times,termItem,@eq,TermCoefficient.new(squareItem.calcFinalValue())]
		@latexStringList << exp.toLatexString()
	end
	def exp_squareRootValue(*args)
		a=args[0]
		termItem = TermCoefficient.new(Math.sqrt(a))
		squareItem = TermCoefficient.new(a)
		exp = Expression.new()
		@latexStringList << "We know that"
		exp.expressionItemList = [termItem,@times,termItem,@eq,squareItem]
		@latexStringList << exp.toLatexString()
		@latexStringList << termItem.toLatexString()+" is a square root of "+squareItem.toLatexString()
	end
	def exp_numSquareZero(*args)
		a=args[0]
		numZero =0
		if a==0
			numZero =0
		end
		while (a%10 ==0) do
			numZero += 1
			a = a/10
		end
		squareNumZero = 2*numZero
		@latexStringList << "If zero in "+a.to_s+" = "+ numZero.to_s
		exp = Expression.new()
		exp.expressionItemList = [TermCoefficient.new(2),@times,TermCoefficient.new(numZero)]
		@latexStringList << "Then zero in "+a.to_s+"^{2} = "+exp.toLatexString()
		@latexStringList << squareNumZero.to_s
	end
	def exp_numNonSquareBetween(*args)
		n=args[0]
		n_next = n+1
		@latexStringList << "There are 2n non perfect square numbers between the squares of the numbers n and (n + 1)."
		@latexStringList << "Hence between "+n.to_s+"^{2} and "+n_next.to_s+"^{2} there are 2\\times"+n.to_s+" = "+(2*n).to_s+" non perfect square numbers "
	end
	def exp_calcSquareBracket(*args)
		a=args[0]
		if a%5==0 && a%10!=0
			square = a**2
			tens = a/10
			@latexStringList << "We know that for a number with unit digit 5, i.e., a5"
			@latexStringList << "{(a5)}^{2} = a(a+1) hunderd + 25"
			@latexStringList << "{(a)}^{2} = "+tens.to_s+"("+(tens+1).to_s+") hunderd + 25 = "+square.to_s
		else
			first = TermCoefficient.new(a-a%10)
			second = TermCoefficient.new(a%10)
			exp1 = Expression.new();exp2 = Expression.new();exp3 = Expression.new();exp4 = Expression.new()
			@latexStringList << a.to_s+"^{2}"
			exp1.expressionItemList = [first,@add,second]; exp1.setExponent(2)
			@latexStringList << exp1.toLatexString()
			exp2.expressionItemList = [first,@bracStart,first,@add,second,@bracEnd,@add,second,@bracStart,first,@add,second,@bracEnd]
			@latexStringList << exp2.toLatexString()
			termAB = Term.new(); termAB.termItemList = [first,second]
			termBA = Term.new(); termBA.termItemList = [second,first]
			firstSquare =first.cloneForOperation();firstSquare.setExponent(2)
			secondSquare=second.cloneForOperation();secondSquare.setExponent(2)
			exp3.expressionItemList = [firstSquare,@add,termAB,@add,termBA,@add,secondSquare]
			@latexStringList << exp3.toLatexString()
			first.simplify();second.simplify();termAB.simplify();termBA.simplify()
			@latexStringList << exp3.toLatexString()
			@latexStringList << (a**2).to_s
		end
			
	end
	def exp_calcRootPrime(*args)
		a=args[0];squareFlag=args[1]
		root = squareFlag ? 2:3
		rootValue = squareFlag ? Math.sqrt(a):Math.cbrt(a)
		rootValue = rootValue.to_i
		op = squareFlag ? @sqrt:@cbrt
		primeList = Prime.prime_division(a)
		@latexStringList << "Prime Factors of "+a.to_s
		exp = Expression.new();fullExp = Expression.new()
		primeList.each do |pair|
			for i in 1..pair[1]
				exp.expressionItemList.concat([@times, TermCoefficient.new(pair[0])])
			end
		end
		exp.deleteItem(0)
		@latexStringList << exp.toLatexString()
		exp.empty()
		primeList.each do |pair|
			prime = TermCoefficient.new(pair[0]); prime.setExponent(root)
			for i in 1..pair[1]
				exp.expressionItemList.concat([@times,prime]) if i%root ==0
			end
		end
		exp.deleteItem(0)
		@latexStringList << exp.toLatexString()
		exp.empty()
		primeList.each do |pair|
			prime = TermCoefficient.new(pair[0]) 
			for i in 1..pair[1]
				exp.expressionItemList.concat([@times,prime]) if i%root ==0
			end
		end
		exp.deleteItem(0)
		exp.setExponent(root)
		@latexStringList << exp.toLatexString()
		exp.setExponent(1)
		fullExp.expressionItemList = [op,@curlyStart,TermCoefficient.new(a),@curlyEnd,@eq,exp,@eq,TermCoefficient.new(rootValue)]
		@latexStringList <<  fullExp.toLatexString()

	end
	def exp_calcRootRepeatedSubtract(*args)
		#Calculate square root using repeated subtraction
	end
	def exp_calcRootRepeatedDivision(*args)
		#Calculate square root using repeated subtraction
	end

	def exp_calcRequiredNumberForRoot(*args)
		a=args[0];divideFlag=args[1];squareFlag=args[2]
		root = squareFlag ? 2:3
		rootValue = squareFlag ? Math.sqrt(a):Math.cbrt(a)
		rootValue = rootValue.to_i
		op = squareFlag ? @sqrt:@cbrt
		opString = divideFlag ? "divide":"multiply"
		op = divideFlag ? @div:@times

		
		requiredList = []
		primeList = Prime.prime_division(a)
		@latexStringList << "Prime Factors of "+a.to_s
		exp = Expression.new()
		primeList.each do |pair|
			for i in 1..pair[1]
				exp.expressionItemList.concat([@times, TermCoefficient.new(pair[0])])
			end
		end
		exp.deleteItem(0)
		@latexStringList << exp.toLatexString()
		exp.empty()
		primeList.each do |pair|
			oddPrime = TermCoefficient.new(pair[0]);
			remainingCount = pair[1]%root
			for j in 1..remainingCount
				requiredList << pair[0]
				exp.expressionItemList.concat([@times,oddPrime]) 
			end
			prime = TermCoefficient.new(pair[0]);
			prime.setExponent(root)
			for i in 1..pair[1]
				exp.expressionItemList.concat([@times,prime]) if i%2 ==0
			end
		end
		exp.deleteItem(0)
		@latexStringList << exp.toLatexString()
		exp.empty()
		requiredNumber = 1
		requiredList.each{ |prime| requiredNumber= requiredNumber*prime}
		requiredListString =""
		requiredList.each{ |prime| requiredListString= requiredListString+" and "+prime.to_s+" "}
		if squareFlag
			@latexStringList << "We know that prime factor "+requiredList[0].to_s+" has no pair." if requiredList.length ==1
			@latexStringList << "We know that prime factors "+requiredListString+" has no pairs." if requiredList.length >1
			@latexStringList << "If we "+opString+a.to_s+" by the factor "+requiredNumber.to_s
		else
			@latexStringList << "We know that prime factor "+requiredList[0].to_s+" doess not appear in a group of three." if requiredList.length ==1
			@latexStringList << "We know that prime factors "+requiredListString+" doess not appear in a group of three." if requiredList.length >1
			@latexStringList << "If we "+opString+a.to_s+" by the factor "+requiredNumber.to_s
		end
		perfectA = divideFlag ? a/requiredNumber:a*requiredNumber
		exp.expressionItemList.concat([TermCoefficient.new(a),op,TermCoefficient.new(requiredNumber),@eq,TermCoefficient.new(perfectA)])
		@latexStringList << exp.toLatexString()
		exp_calcRootPrime(perfectA,squareFlag)

	end
	def exp_estimateSquareRoot(*args)
		a=args[0]
		sqrt = Math.sqrt(a).to_i
		sqrtTerm = TermCoefficient.new(a)
		sqrtTerm.setExponent(0.5)
		first = sqrt - (sqrt%10)
		second = first+10
		firstTerm = TermCoefficient.new(first);secondTerm = TermCoefficient.new(second)
		firstSquareTerm = TermCoefficient.new(first);firstSquareTerm.setExponent(2)
		firstSquareValue = TermCoefficient.new(first**2)
		secondSquareTerm = TermCoefficient.new(second);secondSquareTerm.setExponent(2)
		secondSquareValue = TermCoefficient.new(second**2)
		exp = Expression.new()
		exp.expressionItemList = [firstSquareValue,@lt,TermCoefficient.new(a),@lt,secondSquareValue,@and,firstSquareValue,@eq,firstSquareTerm,@and,secondSquareValue,@eq,secondSquareTerm]
		@latexStringList << exp.toLatexString()
		exp.expressionItemList = [firstSquareValue,@lt,sqrtTerm,@lt,secondSquareValue]
		@latexStringList << exp.toLatexString()
		@latexStringList << "But still we are not very close to the square number"
		first = sqrt.to_i
		second = first+1
		firstTerm = TermCoefficient.new(first);secondTerm = TermCoefficient.new(second)
		firstSquareTerm = TermCoefficient.new(first);firstSquareTerm.setExponent(2)
		firstSquareValue = TermCoefficient.new(first**2)
		secondSquareTerm = TermCoefficient.new(second);secondSquareTerm.setExponent(2)
		secondSquareValue = TermCoefficient.new(second**2)
		exp.expressionItemList = [firstSquareValue,@lt,TermCoefficient.new(a),@lt,secondSquareValue,@and,firstSquareValue,@eq,firstSquareTerm,@and,secondSquareValue,@eq,secondSquareTerm]
		@latexStringList << exp.toLatexString()
		exp.expressionItemList = [firstSquareValue,@lt,sqrtTerm,@lt,secondSquareValue]
		@latexStringList << exp.toLatexString()
		differenceFirst = a-(first**2)
		differenceSecond = (second**2)-a
		answer = (differenceFirst<differenceSecond) ? first:second
		@latexStringList << sqrtTerm.toLatexString()+" is approximately "+ answer.to_s

	end
	def exp_estimateCubeRoot(*args)

	end
	def exp_calcExponentValue(*args)
		a=args[0];b=args[1];denominator=args[2]
		positiveExponent = false
		term =  TermCoefficient.new(a)
		term.setExponent(b)
		reciprocal = TermCoefficient.new(a)
		reciprocal.setExponent(-b)
		exp = Expression.new();productExp = Expression.new()
		value = a**(b.abs)
		productExp.expressionItemList=[TermCoefficient.new(a)]
		for i in 1..b
			productExp.expressionItemList.concat([@times,TermCoefficient.new(a)])
		end
		if b<0 && denominator
			exp.expressionItemList.concat([TermFraction.new(1,term),@eq,reciprocal])
			@latexStringList << exp.toLatexString()
			term.setExponent(-b)
			exp.expressionItemList = [term,@eq]
			exp.expressionItemList.concat(productExp.expressionItemList)
			exp.expressionItemList = [@eq,TermCoefficient.new(value)]
			positiveExponent = true
		elsif b>0 && denominator
			exp.expressionItemList = [TermFraction.new(1,term),@eq,TermFraction.new(1,productExp),@eq,TermFraction.new(1,value)]
			@latexStringList << exp.toLatexString()
			positiveExponent = false
		elsif b<0 && !denominator
			exp.expressionItemList = [term,@eq,TermFraction.new(1,reciprocal),@eq,TermFraction.new(1,productExp),@eq,TermFraction.new(1,value)]
			@latexStringList << exp.toLatexString()
			positiveExponent = false
		elsif b>0 && !denominator
			exp.expressionItemList = [term,@eq]
			exp.expressionItemList.concat(productExp.expressionItemList)
			exp.expressionItemList = [@eq,TermCoefficient.new(value)]
			positiveExponent = true
		end
		@latexStringList << exp.toLatexString()
	end
	def exp_expressUsingExponent(*args)
		a=args[0]
		parts = a.to_s.split(".")
		integral = parts[0].to_i
		decimal = parts[1].to_i if parts.count > 1
		exp = Expression.new()
		exp.expressionItemList.concat([TermCoefficient.new(a),@eq])
		if integral!=0
			integralList = integral.to_s.chars.map(&:to_i)
			integralList.each_with_index do |i,index|
				exponent = integralList.length-1-index
				exp.expressionItemList.concat([@add,TermCoefficient.new(i),@times,TermCoefficient.new(10**exponent)])
			end
		end
		if decimal!=0

			decimalList = decimal.to_s.chars.map(&:to_i)
			decimalList.each_with_index do |i,index|
				exponent = 1+index
				exp.expressionItemList.concat([@add,TermFraction.new(i,10**exponent)])
			end
		end
		exp.deleteItem(2)
		@latexStringList << exp.toLatexString()
		exp.empty()
		if integral!=0
			integralList = integral.to_s.chars.map(&:to_i)
			integralList.each_with_index do |i,index|
				exponent = integralList.length-1-index
				exponentTerm = TermCoefficient.new(10)
				exponentTerm.setExponent(exponent)
				exp.expressionItemList.concat([@add,TermCoefficient.new(i),@times,exponentTerm])
			end
		end
		if decimal!=0
			decimalList = decimal.to_s.chars.map(&:to_i)
			decimalList.each_with_index do |i,index|
				exponent = 1+index
				exponentTerm = TermCoefficient.new(10)
				exponentTerm.setExponent(exponent)
				exp.expressionItemList.concat([@add,TermCoefficient.new(i),@times,exponentTerm])
			end
		end
		@latexStringList << exp.toLatexString()
		
	end
	def exp_simplifyExponentValue(*args)
		a=args[0];b=args[1];c=args[2];d=args[3];calcValue=args[4];multiplyFlag=args[5]
		item1 = TermCoefficient.new(a)
		item1.setExponent(b)
		item2 = TermCoefficient.new(c)
		item2.setExponent(d)
		exp= Expression.new()
		if multiplyFlag
			if a==c
				exponent = Expression.new()
				exponent.expressionItemList=[TermCoefficient.new(b),@add,TermCoefficient.new(d)]
				exponentTerm = TermCoefficient.new(a);exponentTerm.setExponent(exponent)
				finalTerm = TermCoefficient.new(a);finalTerm.setExponent(b+d)
				exp.expressionItemList=[item1,@times,item2,@eq,exponentTerm,@eq,finalTerm]
			elsif b==d
				exponent = Expression.new()
				exponent.expressionItemList=[TermCoefficient.new(a),@times,TermCoefficient.new(c)]
				exponent.setExponent(b)
				finalTerm = TermCoefficient.new(a*c);finalTerm.setExponent(b)
				exp.expressionItemList=[item1,@times,item2,@eq,exponent,@eq,finalTerm]
			end
		else
			if a==c
				exponent = Expression.new()
				exponent.expressionItemList=[TermCoefficient.new(b),@subtract,TermCoefficient.new(d)]
				exponentTerm = TermCoefficient.new(a);exponentTerm.setExponent(exponent)
				finalTerm = TermCoefficient.new(a);finalTerm.setExponent(b-d)
				exp.expressionItemList=[item1,@div,TermFraction.new(1,item2),@eq,exponentTerm,@eq,finalTerm]
			elsif b==d
				frac = TermFraction.new(a,c)
				frac.setExponent(b)
				exp.expressionItemList=[item1,@div,item2,@eq,frac,@eq]
				finalTerm = frac.reduceForm()
				exp.expressionItemList << finalTerm
			end
		end
		@latexStringList << exp.toLatexString()
		lastItem = exp.expressionItemList.last
		if calcValue
			if lastItem.class.name== "TermFraction"
				exp_calcExponentValue(lastItem.calcFinalValue(),lastItem.exponent,true)
			else 
				exp_calcExponentValue(lastItem.base,lastItem.exponent,false)
			end
		end
		

	end
	def exp_exponentialForm(*args)
		a=args[0]
		abs = a.abs
		exponent = Math.log10(abs).floor
		constant = abs.to_f/(10**exponent)
		constantTerm = TermCoefficient.new(constant)
		exponentTerm = TermCoefficient.new(10)
		exponentTerm.setExponent(exponent)
		exp = Expression.new()
		if abs<1 && abs>0
			exp.expressionItemList = [TermCoefficient.new(abs),@eq,TermFraction.new(constantTerm,TermCoefficient.new(10**exponent))]
			@latexStringList << exp.toLatexString()
			exp.expressionItemList = [TermCoefficient.new(abs),@eq,TermFraction.new(constantTerm,exponentTerm)]
			@latexStringList << exp.toLatexString()
		else
			exp.expressionItemList = [TermCoefficient.new(abs),@eq,constantTerm,@times,TermCoefficient.new(10**exponent)]
			@latexStringList << exp.toLatexString()
		end
		exp.empty()
		exp.expressionItemList = [TermCoefficient.new(abs),@eq,constantTerm,@times,exponentTerm]
		@latexStringList << exp.toLatexString()
	end
	def exp_exponentToUsualForm(*args)
		a=args[0];b=args[1]
		exponent = b
		constant = a
		constantTerm = TermCoefficient.new(constant)
		exponentTerm = TermCoefficient.new(10)
		exponentTerm.setExponent(exponent)
		finalValue = a*(10**b)
		exp = Expression.new()
		abs = a.abs
		if abs<1 && abs>0
			exp.expressionItemList = [constantTerm,@times,exponentTerm,@eq,TermFraction.new(constantTerm,exponentTerm)]
			@latexStringList << exp.toLatexString()
			
			exp.expressionItemList = [constantTerm,@times,exponentTerm,@eq,TermFraction.new(constantTerm,TermCoefficient.new(10**exponent))]
			@latexStringList << exp.toLatexString()
		else
			exp.expressionItemList = [constantTerm,@times,exponentTerm,@eq,constantTerm,@times,TermCoefficient.new(10**exponent)]
			@latexStringList << exp.toLatexString()
		end
		exp.expressionItemList = []
		exp.expressionItemList = [constantTerm,@times,exponentTerm,@eq,TermCoefficient.new(finalValue)]
		@latexStringList << exp.toLatexString()
	end
	def exp_exponentOfExponent(*args)
		base = args[0]; coeffBase=TermCoefficient.new(base);firstExpo = args[1]; secondExpo = args[2]
		coeffBase.setExponent(firstExpo);coeffFirstExpo = TermCoefficient.new(firstExpo); coeffSecondExpo = TermCoefficient.new(secondExpo)
		value = base**(firstExpo*secondExpo); coeffValue=TermCoefficient.new(value)

		baseExp = Expression.new(); baseExp.expressionItemList = [coeffBase];baseExp.setExponent(secondExpo) 
		latexStringList<< baseExp.toLatexString()
		expoExp = Expression.new(); expoExp.expressionItemList=[coeffFirstExpo,@times,coeffSecondExpo]
		coeffBase.setExponent(expoExp);baseExp.setExponent(1) ; baseExp.expressionItemList.concat([@eq,coeffValue]);
		latexStringList<< baseExp.toLatexString()
	end
end