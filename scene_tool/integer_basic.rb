require_relative '../ui_math/TermFraction'
class IntegerBasic
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
	def intBas_getSignFromText(*args)
		quesText = args[0]
		positive=false
		#If quesText contains "profit"/"loss"
			#"Since profit and loss	are opposite situations and if profit is represented by ‘+’ sign,	loss can be represented by ‘–’ sign"
		#end
		#elsf quesText contains "sea level": "above"-> positive, "below" -> 
			#"The height of a place above sea level is denoted by a positive number. Height becomes lesser and lesser as we go lower and lower."
		#end
		#elsif quesText contains "earnings"/"spendings"
			#"earnings are represented by ‘+’ sign, then the spendings may be shown by a ‘–’ sign"
		#elsif quesText contains "withdrawal/deposit"
			#"deposit are represented by ‘+’ sign, then the withdrawal may be shown by a ‘–’ sign"
		#end
	end
	def intBas_positionOnNumberLine(*args)
		args = args.sort()
		first = args[0]; second=args[1]
		#As we know that first<second, first will be on the left side of second. And hence second will be on right of first.
	end
	def intBas_compare(*args)
		first = args[0]; second=args[1]
		if first == second
			#both are equal

		elsif first*second < 0
			#Both are numbers of opposite signs
			#compare first with 0 and comment
			#compare second with 0 and comment
			#compare both
		elsif first*second == 0
			#one of them if zero
		elsif first>0
			#both are positive

		elsif first<0
			#both are negative

		end
	end
	def intBas_add(*args)
		if args.count ==2
			a=args[0];b=args[1]
			#Pg6.125
			#if a*b>0 && a>0
				#Both are positive
			#elsif a*b>0 && a<0
				#Both are negative
			#elsif a*b<0 && a.abs > b.abs
				#coeffA =TermCoefficient.new(a);#coeffB = TermCoefficient.new(b)
				#coeffDiff = TermCoefficient.new(a.abs-b.abs); #coeffDiff.negative = a.negative
				#exp.expressionItemList=[coeffDiff,@eq,coeffB.negateTerm(),@eq,coeffB]
				#exp.expressionItemList=[coeffDiff,@eq,TermCoefficient.new(0)] 
				#exp.expressionItemList=[coeffDiff]
			#elsif a*b<0 && a.abs < b.abs
				#coeffA =TermCoefficient.new(a);#coeffB = TermCoefficient.new(b)
				#coeffDiff = TermCoefficient.new(b.abs-a.abs); #coeffDiff.negative = b.negative
				#exp.expressionItemList=[coeffA,@eq,coeffA.negateTerm(),@eq,coeffB]
				#exp.expressionItemList=[coeffDiff,@eq,TermCoefficient.new(0)] 
				#exp.expressionItemList=[coeffDiff]
			#end
		else
			#more than 2 integers to add
			negativeList =[]; positiveList=[];negativeSum=TermCoefficient.new(0);positiveSum=TermCoefficient.new(0)
			args.each do |int|
				negativeList << TermCoefficient.new(int) if int <0; positiveList << TermCoefficient.new(int) if int >0
			end
			exp = Expression.new()
			#exp.expressionList.concat(negativeList with @add between); exp.expressionList.concat(positiveList with @add between); 
			negativeList.each{|item| negativeSum = negativeSum.+@item}; positiveList.each{|item| positiveList = positiveList.+@item}
			#exp.display
			intBas_add(negativeSum,positiveSum)
		end
	end
	def intBas_add(*args)
		if args.count ==2
			a=args[0];b=args[1]
			#coeffA =TermCoefficient.new(a);#coeffB = TermCoefficient.new(b)
			#Pg6.130
			exp.expressionItemList = [coeffA,@subtract,coeffB]
			latexStringList << exp.toLatexString();
			exp.expressionItemList = [coeffA,@add,]
			latexStringList << exp.toLatexString()+"Additive Inverse of "+coeffB.toLatexString()
			exp.expressionItemList = [coeffA,@subtract,coeffB.negateTermItem()]
			latexStringList << exp.toLatexString();

		else
			#more than 2 integers to add
		end
	end
	def intBas_multiple(*args)
		product = args.inject(1) { |prod, element| prod * element }; coeffProduct= TermCoefficient.new(product)
			displayExp = Expression.new()
		if args.count ==2
			a = args[0]; coeffA = TermCoefficient.new(a); coeffA.simplify()
			b = args[1]; coeffB = TermCoefficient.new(b); coeffB.simplify()
			if args[0]*args[1] < 0 
				#One of the item is negative
				latexStringList << "While multiplying a positive integer and a negative integer, we multiply them as whole numbers and put a minus sign (–) before the product"
				displayExp.expressionItemList = [coeffA,@times,coeffB,@eq,@subtract,@bracStart,TermCoefficient.new(a.abs),@times,TermCoefficient.new(b.abs),bracEnd,@eq,coeffProduct]
			elsif args[0]<0
				#Both are negative
				latexStringList << "Product of two negative integers is a positive integer. We multiply the two negative integers as whole numbers and put the positive sign before the product."
				displayExp.expressionItemList = [coeffA,@times,coeffB,@eq,TermCoefficient.new(a.abs),@times,TermCoefficient.new(b.abs),@eq,coeffProduct]
				
			elsif args[0]>0
				#both are positive
				latexStringList << "Product of two positive integers is a positive integer. We multiply the two positive integers as whole numbers. "
				displayExp.expressionItemList = [coeffA,@times,coeffB,@eq,coeffProduct]
			end
		else 
			if product < 0
				#more than 2 items with odd number of negative integers
				latexStringList << "if the number of negative integers in a product is odd, then the product is a negative integer.We multiply them as whole numbers and put a minus sign (–) before the product"
				symbol = @subtract
			else
				#more than 2 items with even number of negative integers
				latexStringList << "if the number of negative integers in a product is even, then the product is a positive integer.We multiply them as whole numbers"
				symbol = @add
			end
			#Creating expression for addition
			args.each_with_index do |int,i|
				displayExp << @times if i!=0
				coeffInt = TermCoefficient.new(int);coeffInt.reduce()
				displayExp << coeffInt
			end
			displayExp.concat([@eq,symbol,@bracStart])
			args.each_with_index do |int,i|
				displayExp << @times if i!=0
				displayExp << TermCoefficient.new(int.abs)
			end
			displayExp.concat([@bracEnd,@eq,coeffProduct])
			latexStringList << displayExp.toLatexString()
	end
	def intBas_multipleEasy(*args)
		#if easy numbers like 10,50,100 can be created
	end
	def intBas_divide(*args)
			displayExp = Expression.new()
		if args.count ==2
			a = args[0]; coeffA = TermCoefficient.new(a); coeffA.simplify()
			b = args[1]; coeffB = TermCoefficient.new(b); coeffB.simplify()
			quotient = a.to_f/b; coeffQuotient= TermCoefficient.new(product)
		
			if args[0]*args[1] < 0 
				#One of the item is negative
				latexStringList << "when we divide a positive integer by a negative integer, we first divide them as whole numbers and then put a minus sign (–) before the quotient." if b<0 
				latexStringList << "when we divide a negative integer by a positive integer, we first divide them as whole numbers and then put a minus sign (–) before the quotient." if a<0 

				displayExp.expressionItemList = [coeffA,@divide,coeffB,@eq,@subtract,@bracStart,TermCoefficient.new(a.abs),@divide,TermCoefficient.new(b.abs),bracEnd,@eq,coeffQuotient]
			elsif args[0]<0
				#Both are negative
				latexStringList << "When we divide a negative integer by a negative integer, we first divide them as whole numbers and then put a positive sign (+)."
				displayExp.expressionItemList = [coeffA,@divide,coeffB,@eq,TermCoefficient.new(a.abs),@divide,TermCoefficient.new(b.abs),@eq,coeffQuotient]
				
			elsif args[0]>0
				#both are positive
				latexStringList << "When we divide a positive integer by a positive integer, we first divide them as whole numbers"
				displayExp.expressionItemList = [coeffA,@divide,coeffB,@eq,coeffQuotient]
			end
		end
	end
end