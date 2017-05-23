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
		quesText = args[0].to_s
		positive=false
		if (quesText.include?"profit")||(quesText.include?"loss")
			@latexStringList << "Since profit and loss are opposite situations and if profit is represented by ‘+’ sign,loss can be represented by ‘–’ sign"
		elsif (quesText.include?"sea level")||(quesText.include?"above")
			@latexStringList << "The height of a place above sea level is denoted by a positive number."
		elsif (quesText.include?"sea level")||(quesText.include?"below")
			@latexStringList << "The height of a place below sea level is denoted by a negative number."
		elsif (quesText.include?"earnings")||(quesText.include?"spendings")
			@latexStringList << "As earnings are represented by ‘+’ sign, hence the spendings may be shown by a ‘–’ sign"
		elsif (quesText.include?"withdrawal")||(quesText.include?"deposit")
			@latexStringList << "Deposit are represented by ‘+’ sign, then the withdrawal may be shown by a ‘–’ sign"
		end
	end
	def intBas_positionOnNumberLine(*args)
		args = args.sort()
		first = args[0].to_s; second=args[1].to_s
		@latexStringList << "As we know that "+first+"<"+second+", "+first+" will be on the left side of "+second+". And hence "+second+" will be on right of "+first+"."
	end
	def intBas_compare(*args)
		args = args.sort()
		first = args[0]; second=args[1]
		@latexStringList << "We know that on a number line the number increases as we move to the right and decreases as we move to the left"
		if first == second
			#both are equal
			first=first.to_s; second=second.to_s
			@latexStringList << "As we know that "+first+"="+second+", both "+first+" and "+second+" will be on the same point on number line."
		elsif first*second < 0
			#Both are numbers of opposite signs
			first=first.to_s; second=second.to_s
			#compare first with 0 and comment
			@latexStringList << "As we know that "+first+"<0, "+first+" is on the left of 0"
			#compare second with 0 and comment
			@latexStringList << "And we know that "+second+">0, "+second+" is on the right of 0"
			#compare both
			@latexStringList << "Therefore "+first+" < 0 < "+second+", and hence "+first+" < "+second
		elsif first*second == 0
			#one of them if zero

		elsif first>0
			#both are positive
			first=first.to_s; second=second.to_s
			@latexStringList << "As we know that "+first+"<"+second+", "+first+" is on the left of "+second
		elsif first<0
			#both are negative
			first=first.to_s; second=second.to_s
			@latexStringList << "As we know that "+first+"<"+second+", "+first+" is on the left of "+second
		
		end
	end

	def intBas_add(*args)
		exp = Expression.new()
		if args.count ==2
			a=args[0];b=args[1]
			#Pg6.125
			if a*b>0 && a>0
				#Both are positive
				c=(a+b).to_s;a=a.to_s;b=b.to_s
				@latexStringList << "You add when you have two positive integers like (+"+a+") + (+"+b+") = +"+c+" [= "+a+" + "+b+"]."
			elsif a*b>0 && a<0
				#Both are negative
				c=(a+b)
				@latexStringList << "You add when you have two negative integers and the answer will take a minus(-) sign like ("+a.to_s+") + ("+b.to_s+")= -("+a.abs+" + "+b.abs+") = "+c.to_s+"."
			elsif a*b<0 && a.abs > b.abs
				coeffA =TermCoefficient.new(a);coeffB = TermCoefficient.new(b)
				coeffDiff = TermCoefficient.new(a.abs-b.abs); coeffDiff.negative = coeffA.negative
				exp.expressionItemList=[coeffDiff,@add,coeffB.negateTermItem(),@add,coeffB]
				@latexStringList << exp.toLatexString()
				exp.expressionItemList=[coeffDiff,@add,TermCoefficient.new(0)] 
				@latexStringList << exp.toLatexString()
				exp.expressionItemList=[coeffDiff]
				@latexStringList << exp.toLatexString()
			elsif a*b<0 && a.abs < b.abs
				coeffA =TermCoefficient.new(a);coeffB = TermCoefficient.new(b)
				coeffDiff = TermCoefficient.new(b.abs-a.abs); coeffDiff.negative = b.negative
				exp.expressionItemList=[coeffA,@eq,coeffA.negateTermItem(),@eq,coeffB]
				@latexStringList << exp.toLatexString()
				exp.expressionItemList=[coeffDiff,@eq,TermCoefficient.new(0)]
				@latexStringList << exp.toLatexString() 
				exp.expressionItemList=[coeffDiff]
				@latexStringList << exp.toLatexString()
			end
		else
			#more than 2 integers to add
			negativeList =[]; positiveList=[];negativeSum=TermCoefficient.new(0);positiveSum=TermCoefficient.new(0)
			exp = Expression.new()
			args.each_with_index do |int,index|
				exp.expressionItemList << TermCoefficient.new(int); exp.expressionItemList << @add if index > 0
				negativeList << TermCoefficient.new(int) if int <0; positiveList << TermCoefficient.new(int) if int >0
			end
			@latexStringList << exp.toLatexString()

			exp.expressionItemList=[]
			negativeList.each_with_index do |int,index|
				exp.expressionItemList << TermCoefficient.new(int); exp.expressionItemList << @add if index > 0
			end
			positiveList.each_with_index do |int,index|
				exp.expressionItemList << TermCoefficient.new(int); exp.expressionItemList << @add if index > 0
			end
			@latexStringList << exp.toLatexString()

			negativeList.each{|item| negativeSum = negativeSum.+@item}; positiveList.each{|item| positiveList = positiveList.+@item}
			#exp.display
			intBas_add(negativeSum,positiveSum)
		end
	end

	def intBas_subtract(*args)
		exp = Expression.new()
		if args.count ==2
			a=args[0];b=args[1];ans=a-b
			coeffA =TermCoefficient.new(a);coeffA.simplify();coeffB = TermCoefficient.new(b);coeffB.simplify();coeffAns=TermCoefficient.new(ans);coeffAns.simplify()
			@latexStringList << "To subtract an integer from another integer it is enough to add the additive inverse of the integer that is being subtracted, to the other integer."
			exp.expressionItemList = [coeffA,@subtract,coeffB]
			@latexStringList << exp.toLatexString();
			exp.expressionItemList = [coeffA,@add,]
			@latexStringList << exp.toLatexString()+"Additive Inverse of "+coeffB.toLatexString()
			exp.expressionItemList = [coeffA,@add,coeffB.negateTermItem()]
			@latexStringList << exp.toLatexString();
			exp.expressionItemList = [coeffAns]
			@latexStringList << exp.toLatexString();
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
				@latexStringList << "While multiplying a positive integer and a negative integer, we multiply them as whole numbers and put a minus sign (–) before the product"
				displayExp.expressionItemList = [coeffA,@times,coeffB,@eq,@subtract,@bracStart,TermCoefficient.new(a.abs),@times,TermCoefficient.new(b.abs),@bracEnd,@eq,coeffProduct]
			elsif args[0]<0
				#Both are negative
				@latexStringList << "Product of two negative integers is a positive integer. We multiply the two negative integers as whole numbers and put the positive sign before the product."
				displayExp.expressionItemList = [coeffA,@times,coeffB,@eq,TermCoefficient.new(a.abs),@times,TermCoefficient.new(b.abs),@eq,coeffProduct]
				
			elsif args[0]>0
				#both are positive
				@latexStringList << "Product of two positive integers is a positive integer. We multiply the two positive integers as whole numbers. "
				displayExp.expressionItemList = [coeffA,@times,coeffB,@eq,coeffProduct]
			end
		else 
			if product < 0
				#more than 2 items with odd number of negative integers
				@latexStringList << "if the number of negative integers in a product is odd, then the product is a negative integer.We multiply them as whole numbers and put a minus sign (–) before the product"
				symbol = @subtract
			else
				#more than 2 items with even number of negative integers
				@latexStringList << "if the number of negative integers in a product is even, then the product is a positive integer.We multiply them as whole numbers"
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
			
		end
		@latexStringList << displayExp.toLatexString()
	end

	def intBas_multipleEasy(*args)
		#if easy numbers like 10,50,100 can be created
	end
	def intBas_divide(*args)
			displayExp = Expression.new()
		if args.count ==2
			a = args[0]; coeffA = TermCoefficient.new(a); coeffA.simplify()
			b = args[1]; coeffB = TermCoefficient.new(b); coeffB.simplify()
			quotient = a.to_f/b; coeffQuotient= TermCoefficient.new(quotient)
		
			if args[0]*args[1] < 0 
				#One of the item is negative
				@latexStringList << "when we divide a positive integer by a negative integer, we first divide them as whole numbers and then put a minus sign (–) before the quotient." if b<0 
				@latexStringList << "when we divide a negative integer by a positive integer, we first divide them as whole numbers and then put a minus sign (–) before the quotient." if a<0 

				displayExp.expressionItemList = [coeffA,@div,coeffB,@eq,@subtract,@bracStart,TermCoefficient.new(a.abs),@div,TermCoefficient.new(b.abs),@bracEnd,@eq,coeffQuotient]
			elsif args[0]<0
				#Both are negative
				@latexStringList << "When we divide a negative integer by a negative integer, we first divide them as whole numbers and then put a positive sign (+)."
				displayExp.expressionItemList = [coeffA,@div,coeffB,@eq,TermCoefficient.new(a.abs),@div,TermCoefficient.new(b.abs),@eq,coeffQuotient]
				
			elsif args[0]>0
				#both are positive
				@latexStringList << "When we divide a positive integer by a positive integer, we first divide them as whole numbers"
				displayExp.expressionItemList = [coeffA,@div,coeffB,@eq,coeffQuotient]
			end
		end
		@latexStringList << displayExp.toLatexString()
	end

end