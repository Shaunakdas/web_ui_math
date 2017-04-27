require_relative '../ui_math/TermFraction'
require 'prime'
class Exponent
	attr_accessor :latexStringList
	def initialize()
		latexStringList=[]
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
	def squareOneDigit(a)
		oneDigit = a%10
		if oneDigit==1 || oneDigit==9
			latexStringList << "if a number has "+oneDigit+" in the unit’s place, then it’s square ends in 1."
		elsif oneDigit==4 || oneDigit==6
			latexStringList << "if a number has "+oneDigit+" in the unit’s place, then it’s square ends in 6."
		elsif oneDigit==5
			latexStringList << "if a number has "+oneDigit+" in the unit’s place, then it’s square ends in 5."
		end
	end
	def squareValue(a)
		termItem = TermCoefficient.new(a)
		squareItem = termItem.cloneOperation()
		squareItem.setExponent(2)
		exp = Expression.new()
		exp.expressionList = [squareItem,@eq,termItem,@times,termItem,@eq,squareItem.calcFinalValue()]
		latexStringList << exp.toLatexString()
	end
	def squareRootValue(a)
		termItem = TermCoefficient.new(Math.sqrt(a))
		squareItem = TermCoefficient.new(a)
		exp = Expression.new()
		latexStringList << "We know that"
		exp.expressionList = [termItem,@times,termItem,@eq,squareItem]
		latexStringList << exp.toLatexString()
		latexStringList << termItem.toLatexString()+" is a square root of "+squareItem.toLatexString()
	end
	def numSquareZero(a)
		numZero =0
		if a==0
			numZero =0
		end
		while (a%10 ==0) do
			numZero += 1
			a = a%10
		end
		squareNumZero = 2*numZero
		latexStringList << "If zero in "+a+" = "+ numZero.to_s
		exp = Expression.new()
		exp.expressionList = [TermCoefficient.new(2),@times,TermCoefficient.new(numZero)]
		latexStringList << "Then zero in "+a+"^{2} = "+exp.toLatexString()
		latexStringList << squareNumZero.to_s
	end
	def numNonSquareBetween(n)
		next = n+1
		latexStringList << "There are 2n non perfect square numbers between the squares of the numbers n and (n + 1)."
		latexStringList << "Hence between "+n.to_s+"^{2} and "+next.to_s+"^{2} there are 2\\times"+n.to_s+" non perfect square numbers "
	end
	def numNonSquareBetween(n)
		next = n+1
		latexStringList << "There are 2n non perfect square numbers between the squares of the numbers n and (n + 1)."
		latexStringList << "Hence between "+n.to_s+"^{2} and "+next.to_s+"^{2} there are 2\\times"+n.to_s+" non perfect square numbers "
	end
	def calcSquareBracket(a)
		if a%5==0 && a%10!=0
			latexStringList << "We know that for a number with unit digit 5, i.e., a5"
			latexStringList << "{(a5)}^{2} = a(a+1) hunderd + 25"
		else
			first = TermCoefficient.new(a%10)
			second = TermCoefficient.new(a=a%10)
			exp1 = Expression.new();exp2 = Expression.new();exp3 = Expression.new();exp4 = Expression.new()
			latexStringList << a+"^{2}"
			exp1.expressionList = [first,@add,second]; exp1.setExponent(2)
			latexStringList << exp1.toLatexString()
			exp2.expressionList = [first,@bracStart,first,@add,second,@bracEnd,@add,second,@bracStart,first,@add,second,@bracEnd]
			latexStringList << exp2.toLatexString()
			termAB = Term.new(); termAB.termItemList = [first,second]
			termBA = Term.new(); termBA.termItemList = [second,first]
			first.setExponent(2);second.setExponent(2)
			exp3.expressionList = [first,@add,termAB,@add,termBA,@add,second]
			latexStringList << exp3.toLatexString()
			first.simplify();second.simplify();termAB.simplify();termBA.simplify()
			latexStringList << exp3.toLatexString()
			latexStringList << (a**2).to_s
		end
			
	end
	def calcRootPrime(a,squareFlag)
		root = squareFlag? 2:3
		rootValue = squareFlag? Math.sqrt(2):Math.cbrt(3)
		op = squareFlag? @sqrt:@cbrt
		primeList = Prime.prime_division(a)
		latexStringList << "Prime Factors of "+a
		exp = Expression.new()
		primeList.each do |pair|
			1..pair[1].each do i
				exp.expressionItemList.concat[@times, TermCoefficient.new(pair[0])]
			end
		end
		exp.delete_at(0)
		latexStringList << exp.toLatexString()
		exp =[]
		primeList.each do |pair|
			prime = TermCoefficient.new(pair[0]); prime.setExponent(root)
			1..pair[1].each do i
				exp.expressionItemList.concat([@times,prime]) if i%root ==0
			end
		end
		exp.delete_at(0)
		latexStringList << exp.toLatexString()
		exp =[]
		primeList.each do |pair|
			prime = TermCoefficient.new(pair[0]) 
			1..pair[1].each do i
				exp.expressionItemList.concat([@times,prime]) if i%root ==0
			end
		end
		exp.delete_at(0)
		exp.setExponent(root)
		latexStringList << exp.toLatexString()
		exp.setExponent(1)
		latexStringList <<  op.toLatexString()+"{"+a+"} = "+exp.toLatexString()+rootValue.to_s

	end
	def calcRequiredNumberForRoot(a,divideFlag,squareFlag)
		root = squareFlag? 2:3
		rootValue = squareFlag? Math.sqrt(2):Math.cbrt(3)
		op = squareFlag? @sqrt:@cbrt
		opString = divideFlag? "divide":"multiply"
		op = divideFlag? @div:@times

		
		requiredList = []
		primeList = Prime.prime_division(a)
		latexStringList << "Prime Factors of a"
		exp = Expression.new()
		primeList.each do |pair|
			1..pair[1].each do i
				exp.expressionItemList.concat[@times, TermCoefficient.new(pair[0])]
			end
		end
		exp.delete_at(0)
		latexStringList << exp.toLatexString()
		exp =[]
		primeList.each do |pair|
			remainingCount = pair[1]%root
			1..remainingCount do |j|
				requiredList << pair[0]
			end
			prime = TermCoefficient.new(pair[0]);
			prime.setExponent(2)
			1..pair[1].each do i
				exp.expressionItemList.concat([@times,prime]) if i%2 ==0
			end
		end
		exp.delete_at(0)
		latexStringList << exp.toLatexString()
		exp =[]
		requiredNumber = 1
		requiredList.each{ |prime| requiredNumber= requiredNumber*prime}
		requiredListString =""
		requiredList.each{ |prime| requiredListString= requiredListString+" and "+prime+" "}
		if squareFlag
			latexStringList << "We know that prime factor "+requiredList[0].to_s+" has no pair." if requiredList.length ==1
			latexStringList << "We know that prime factors "+requiredListString+" has no pairs." if requiredList.length >1
			latexStringList << "If we "+opString+a.to_s+" by the factor "+requiredNumber.to_s
		else
			latexStringList << "We know that prime factor "+requiredList[0]+" doess not appear in a group of three." if requiredList.length ==1
			latexStringList << "We know that prime factors "+requiredListString+" doess not appear in a group of three." if requiredList.length >1
			latexStringList << "If we "+opString+a.to_s+" by the factor "+requiredNumber.to_s
		end
		perfectA = divideFlag? a/requiredNumber:a*requiredNumber
		exp.expressionItemList.concat([TermCoefficient.new(a),op,TermCoefficient.new(requiredNumber),@eq,TermCoefficient.new(perfectA)])
		latexStringList << exp.toLatexString()
		calcSquareRootPrime(perfectA,squareFlag)

	end
	def estimateSquareRoot(a)
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
		latexStringList << exp.toLatexString()
		exp.expressionItemList = [firstSquareValue,@lt,sqrtTerm,@lt,secondSquareValue]
		latexStringList << exp.toLatexString()
		latexStringList << "But still we are not very close to the square number"
		first = sqrt.to_i
		second = first+1
		firstTerm = TermCoefficient.new(first);secondTerm = TermCoefficient.new(second)
		firstSquareTerm = TermCoefficient.new(first);firstSquareTerm.setExponent(2)
		firstSquareValue = TermCoefficient.new(first**2)
		secondSquareTerm = TermCoefficient.new(second);secondSquareTerm.setExponent(2)
		secondSquareValue = TermCoefficient.new(second**2)
		exp.expressionItemList = [firstSquareValue,@lt,TermCoefficient.new(a),@lt,secondSquareValue,@and,firstSquareValue,@eq,firstSquareTerm,@and,secondSquareValue,@eq,secondSquareTerm]
		latexStringList << exp.toLatexString()
		exp.expressionItemList = [firstSquareValue,@lt,sqrtTerm,@lt,secondSquareValue]
		latexStringList << exp.toLatexString()
		differenceFirst = a-(first**2)
		differenceSecond = (second**2)-a
		answer = (differenceFirst<differenceSecond)? first:second
		latexStringList << sqrtTerm.toLatexString()+" is approximately "+ answer.to_s

	end
	def calcExponentValue(a,b,denominator)
		positiveExponent = false
		term =  TermCoefficient.new(a)
		term.setExponent(b)
		reciprocal = TermCoefficient.new(a)
		reciprocal.setExponent(-b)
		exp = Expression.new();productExp = Expression.new()
		value = a**(b.abs)
		productExp.expressionItemList=[TermCoefficient.new(a)]
		1..b do i
			productExp.expressionItemList.concat([@times,TermCoefficient.new(a)])
		end
		if b<0 && denominator
			exp.expressionItemList.concat([TermFraction.new(1,term),@eq,reciprocal])
			latexStringList << exp.toLatexString()
			term.setExponent(-b)
			exp.expressionItemList = [term,@eq]
			exp.expressionItemList.concat(productExp)
			exp.expressionItemList = [@eq,TermCoefficient.new(value)]
			positiveExponent = true
		elsif b>0 && denominator
			exp.expressionItemList = [TermFraction.new(1,term),@eq,TermFraction.new(1,productExp),@eq,TermFraction.new(1,value)]
			latexStringList << exp.toLatexString()
			positiveExponent = false
		elsif b<0 && !denominator
			exp.expressionItemList = [term,@eq,TermFraction.new(1,reciprocal),@eq,TermFraction.new(1,productExp),@eq,TermFraction.new(1,value)]
			latexStringList << exp.toLatexString()
			positiveExponent = false
		elsif b>0 && !denominator
			exp.expressionItemList = [term,@eq]
			exp.expressionItemList.concat(productExp)
			exp.expressionItemList = [@eq,TermCoefficient.new(value)]
			positiveExponent = true
		end
		latexStringList << exp.toLatexString()
	end
	def expressUsingExponent(a)
		abs = a.abs
		integral = abs.to_i
		decimal = abs-abs.to_i
		exp = Expression.new()
		exp.concat([TermCoefficient.new(a),@eq])
		if integral!=0
			integralList = integral.to_s.chars.map(&:to_i)
			integralList.each_with_index do |i,index|
				exponent = integralList.length-1-index
				exp.concat([@add,TermCoefficient.new(i),@times,TermCoefficient.new(10**exponent)])
			end
		end
		if decimal!=0
			decimalList = decimal.to_s.chars.map(&:to_i)
			decimalList.each_with_index do |i,index|
				exponent = 1+index
				exp.concat([@add,TermFraction.new(i,10**exponent)])
			end
		end
		latexStringList << exp.toLatexString()
		exp = []
		if integral!=0
			integralList = integral.to_s.chars.map(&:to_i)
			integralList.each_with_index do |i,index|
				exponent = integralList.length-1-index
				exponentTerm = TermCoefficient.new(10)
				exponentTerm.setExponent(exponent)
				exp.concat([@add,TermCoefficient.new(i),@times,exponentTerm])
			end
		end
		if decimal!=0
			decimalList = decimal.to_s.chars.map(&:to_i)
			decimalList.each_with_index do |i,index|
				exponent = 1+index
				exponentTerm = TermCoefficient.new(10)
				exponentTerm.setExponent(exponent)
				exp.concat([@add,TermCoefficient.new(i),@times,exponentTerm])
			end
		end
		latexStringList << exp.toLatexString()
		
	end
	def simplifyExponentValue(a,b,c,d,calcValue,multiplyFlag)
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
				exp.expressionItemList=[item1,@times,TermFraction.new(1,item2),@eq,exponentTerm,@eq,finalTerm]
			elsif b==d
				exponent = TermFraction.new(a,c)
				exponent.setExponent(b)
				exp.expressionItemList=[item1,@times,item2,@eq,exponent]
				finalTerm = exponent.reduce()
				exp.expressionItemList << finalTerm
			end
		end
		latexStringList << exp.toLatexString()
		if calcValue
			if exp.last.class.name== "TermFraction"
				calcExponentValue(exp.baseDenominator.base,exp.baseDenominator.exponent,true)
			else 
				calcExponentValue(exp.last.base,exp.last.exponent,false)
			end
		end
		

	end
	def exponantialForm(a)
		abs = a.abs
		exponent = Math.log10(abs).floor
		constant = abs/(10**exponent)
		constantTerm = TermCoefficient.new(constant)
		exponentTerm = TermCoefficient.new(10)
		exponentTerm.setExponent(exponent)
		exp = Expression.new()
		if abs<1 && abs>0
			exp.expressionItemList = [abs,@eq,TermFraction.new(constantTerm,TermCoefficient.new(10**exponent))]
			latexStringList << exp.toLatexString()
			exp.expressionItemList = [abs,@eq,TermFraction.new(constantTerm,exponentTerm)]
			latexStringList << exp.toLatexString()
		else
			exp.expressionItemList = [abs,@eq,constantTerm,@times,TermCoefficient.new(10**exponent)]
			latexStringList << exp.toLatexString()
		end
		exp = []
		exp.expressionItemList = [abs,@eq,constantTerm,@times,exponentTerm]
		latexStringList << exp.toLatexString()
	end
	def exponantToUsualForm(a,b)
		exponent = b
		constant = a
		constantTerm = TermCoefficient.new(constant)
		exponentTerm = TermCoefficient.new(10)
		exponentTerm.setExponent(exponent)
		finalValue = a*(10**b)
		exp = Expression.new()
		if abs<1 && abs>0
			exp.expressionItemList = [constantTerm,@times,exponentTerm,@eq,TermFraction.new(constantTerm,exponentTerm)]
			latexStringList << exp.toLatexString()
			
			exp.expressionItemList = [constantTerm,@times,exponentTerm,@eq,TermFraction.new(constantTerm,TermCoefficient.new(10**exponent))]
			latexStringList << exp.toLatexString()
		else
			exp.expressionItemList = [constantTerm,@times,exponentTerm,@eq,constantTerm,@times,TermCoefficient.new(10**exponent)]
			latexStringList << exp.toLatexString()
		end
		exp = []
		exp.expressionItemList = [constantTerm,@times,exponentTerm,@eq,TermCoefficient.new(finalValue)]
		latexStringList << exp.toLatexString()
	end
end