require_relative '../ui_math/TermFraction'
class DecimalBasic
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
	def decBas_placeValueTable(*args)
		#How to put components of numbers in digits
	end
	def decBas_fracToDecimal(*args)
		frac = TermFraction.new(args[0],args[1]); num=args[0]; den = args[1]
		#For new denominator of form 10^x, find x
		requiredDenExpo = (Math.log10(den)).ceil
		#to get the multiplier for new denominator
		mult = (10**requiredDenExpo).to_f/den; coeffMult =TermCoefficient.new(mult)
		#final Fraction : 
		finalFrac = TermFraction.new(mult*num,mult*den)
		#Multiplying both the denominator and numerator with mult: display
		numExp = Expression.new(); denExp = Expression.new()
		numExp.expressionItemList = [frac.baseNumerator,@times,coeffMult]; denExp.expressionItemList = [frac.baseDenominator,@times,coeffMult]
		answer = TermCoefficient.new(finalFrac.cloneForOperation().finalValue())
		exp=Expression.new()
		exp.expressionItemList = [frac,@eq,TermFraction.new(numExp,denExp),@eq,finalFrac,@eq,answer]
		@latexStringList << exp.toLatexString()

	end
	def decBas_decToFrac(*args)
		decimal = args[0]; coeffDec = TermCoefficient.new(decimal)
		#finding length of integer after decimal point:-
		decimalLength = (decimal%1).to_s.length-2
		#Find required denominator as power of 10
		den = 10**(decimalLength.abs)
		#dividing decimal into integrl part and decimal part
		decimalPart = decimal%1 ; coeffDecPart = TermCoefficient.new(decimalPart)
		decFrac = TermFraction.new(wholeNum(decimalPart),den)

		integralPart = decimal - decimalPart ; coeffIntPart = TermCoefficient.new(integralPart)
		exp=Expression.new()
		exp.expressionItemList = [coeffDec,@eq,coeffIntPart,@add,decFrac,@eq,coeffIntPart,@add,decFrac.reduceFormWithDen()]
		@latexStringList << exp.toLatexString()
		exp.expressionItemList = [coeffDec,@eq,coeffIntPart,decFrac.reduceFormWithDen()] if integralPart>0
		exp.expressionItemList = [coeffDec,@eq,decFrac.reduceFormWithDen()] if integralPart == 0
		@latexStringList << exp.toLatexString()
		
	end
	def decBas_placeValueTableToDec(*args)
		decimal = args[0]; coeffDec = TermCoefficient.new(decimal)
		#finding length of integer after decimal point:-
		decimalLength = (decimal%1).to_s.length-2
		#Find required denominator as power of 10
		den = 10**(decimalLength.abs)
		#find list of digits in number without decimal point
		digitArray = decimal.to_s.chars; digitArray.delete('.'); digitArray =digitArray.map(&:to_i)
		#Find maximum exponent of 10 possible in given decimal
		exponent = Math.log10(decimal).ceil-1
		puts "Exponent" + exponent.to_s
		exp=Expression.new()
		exp.expressionItemList = [TermCoefficient.new(decimal),@eq]
		digitArray.each_with_index do |digit,i|
			exp.expressionItemList << @add if i>0
			exp.expressionItemList << TermCoefficient.new(digit)
			exp.expressionItemList << @times
			exp.expressionItemList << TermCoefficient.new(10**(exponent-i)) if i<exponent+1
			exp.expressionItemList << TermFraction.new(1,10**(i-exponent)) if i>exponent
			puts exp.toLatexString()
		end
		@latexStringList << exp.toLatexString()
		exp.expressionItemList = [TermCoefficient.new(decimal),@eq]
		digitArray.each_with_index do |digit,i|
			exp.expressionItemList << @add if i>0
			exp.expressionItemList << TermCoefficient.new(digit*(10**(exponent-i))) if i<exponent+1
			exp.expressionItemList << TermFraction.new(digit,10**(i-exponent)) if i>exponent
		end
		#from digitArray, get the decimal by joining and adding decimal point at correct 
		@latexStringList << exp.toLatexString()
	end
	def wholeNum(dec)
		digitArray = dec.to_s.chars; digitArray.delete('.'); 
		return digitArray.join('').to_i
	end
	def decBas_multipleBasic(*args)
		product = args.inject(1) { |prod, element| prod * element };productWhole = args.inject(1) { |prod, element| prod * wholeNum(element) };
		puts product
		displayExp = Expression.new();productExp = Expression.new()
		size= args.size-1
		for i in 0..size
			productExp.expressionItemList << @times if i!=0
			productExp.expressionItemList << TermCoefficient.new(args[i])
		end
		@latexStringList << "First we multiply them as whole numbers ignoring the decimal point"
		for i in 0..size
			displayExp.expressionItemList << @times if i!=0
			displayExp.expressionItemList << TermCoefficient.new(wholeNum(args[i]))
		end
		displayExp.expressionItemList.concat([@eq,TermCoefficient.new(productWhole)])
		@latexStringList << "In "+productExp.toLatexString()+", we found "+displayExp.toLatexString()
		@latexStringList << "The number of digits to be counted is obtained by adding the number of digits to the right of the decimal point in the decimal numbers that are being multiplied."
		#Calculating number of decimal digits in decimals
		productDecimalLength = (product%1).to_s.length-2
		displayExp.expressionItemList =[]
		for i in 0..size
			displayExp.expressionItemList << @add if i!=0
			displayExp.expressionItemList << TermCoefficient.new((args[i]%1).to_s.length-2)
		end
		displayExp.expressionItemList.concat([@eq,TermCoefficient.new(productDecimalLength)])
		@latexStringList << "In "+productExp.toLatexString()+", For placing the decimal in the product obtained, we count "+displayExp.toLatexString()+"digits starting from the rightmost digit."
		productExp.expressionItemList.concat([@eq,TermCoefficient.new(product)])
		@latexStringList << "Thus, "+productExp.toLatexString()
	end
	def decBas_multipleTens(*args)
		mult = args[0];multTen = args[1];coeffMult = TermCoefficient.new(mult); coeffMultTen =  TermCoefficient.new(multTen)
		product = args[0]*args[1]; coeffProduct = TermCoefficient.new(product)
		decimalLength = (mult%1).to_s.length-2;den = 10**(decimalLength.abs)
		displayExp = Expression.new(); displayExp.expressionItemList = [coeffMult,@times,coeffMultTen,@eq,TermFraction.new(wholeNum(mult),den),@times,coeffMultTen,@eq,coeffProduct]
		@latexStringList << displayExp.toLatexString()
	end
	def decBas_divisionWhole(*args)
		dividend = args[0];divisor = args[1];coeffDividend = TermCoefficient.new(dividend); coeffDivisor =  TermCoefficient.new(divisor)
		quotient = args[0].to_f/args[1]; coeffQuotient = TermCoefficient.new(quotient)
		decimalLength = (dividend%1).to_s.length-2;den = 10**(decimalLength.abs)
		displayExp = Expression.new();
		if (Math.log10(divisor))%1 == 0 
			#divisor is power of ten
			displayExp.expressionItemList = [coeffDividend,@div,coeffDivisor,@eq,TermFraction.new(wholeNum(dividend),den),@times,TermFraction.new(1,coeffDivisor),@eq,coeffQuotient]
			@latexStringList << displayExp.toLatexString()
		elsif divisor%1 == 0 
			#divisor is whole
			displayExp.expressionItemList = [coeffDividend,@div,coeffDivisor,@eq,TermFraction.new(wholeNum(dividend),den),@times,TermFraction.new(1,coeffDivisor)]
			@latexStringList << displayExp.toLatexString()
			displayExp.expressionItemList = [coeffDividend,@div,coeffDivisor,@eq,TermFraction.new(1,den),@times,TermFraction.new(wholeNum(dividend),coeffDivisor),@eq,coeffQuotient]
			@latexStringList << displayExp.toLatexString()
		else
			#divisor is decimal
			divisorDecimalLength = (divisor%1).to_s.length -2;divisorTen = 10**(decimalLength.abs)
			displayExp.expressionItemList = [coeffDividend,@div,coeffDivisor,@eq,TermFraction.new(wholeNum(dividend),den),@times,TermFraction.new(divisorTen,coeffDividend)]
			@latexStringList << displayExp.toLatexString()
			if quotient%1 >0
				#there will power of ten in denominator
				den = den/divisorTen
				displayExp.expressionItemList = [coeffDividend,@div,coeffDivisor,@eq,TermFraction.new(1,den),@times,TermFraction.new(wholeNum(dividend),coeffDividend),@eq,coeffQuotient]
				@latexStringList << displayExp.toLatexString()
			else
				#there will be power of ten in numerator
				divisorTen =  divisorTen/den
				displayExp.expressionItemList = [coeffDividend,@div,coeffDivisor,@eq,TermFraction.new(wholeNum(dividend),coeffDividend),@times,TermFraction.new(divisorTen,1),@eq,coeffQuotient]
				@latexStringList << displayExp.toLatexString()
			end
		end
		
	end
end