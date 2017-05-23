require_relative '../ui_math/TermFraction'
require 'prime'
class NumberSystem
	attr_accessor :latexStringList,:numberTableList
	def initialize()
		@latexStringList=[]
		@numberTableList = []
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
	def numberTableToString(a)
		#convert 2 dim array into html table
		table= "<table>\n<tr>" << a.map do |column|
		    "<td>" << column.map do |element|
		      element.to_s
		    end.join("</td><td>") << "</td>"
		  end.join("</tr>\n<tr>") << "</tr>\n</table>\n"
		 return table
	end
	def numSys_setTable(*args)
		 rowCount=args[0];colCount=args[1];inputArgs=args[2];
		 shift =true if args[3] 
		numberTable = Array.new(rowCount){Array.new(colCount)}
		#for loop going from second row to secondLast row of number table-> int i=1 to rowCount-2
		(1..(rowCount-2)).each do |row|
			#Break args[i-1] into array-> rowArray
			rowArray = inputArgs[row-1].to_s.split('').map(&:to_i)
			#numberTable[i] = rowArray
			numberTable[row] = rowArray
			#blankCount = colCount-rowArray.size
			blankCount = colCount-rowArray.size
			#Insert blankCount number of blanks in numberTable[i]
			numberTable[row] = Array.new(blankCount)+numberTable[row]
			numberTable[row] = numberTable[row] + Array.new(row-1) if shift
		#end
		end
		return numberTable
	end
	def numSys_sum(*args)
		#check for shift for product
		shift= false
		if args[0] == true
			shift = true
			args = args[1..-1]
		end
		#sort args list in decreasing order
		args = args.sort {|x,y| -(x <=> y)}
		finalSum = args.inject(0){|sum,x| sum + x.to_i }
		#Get number of columns of number table
		#Set number of row of number table
		colCount=args[0].to_s.size; rowCount=args.size+2;startCol=0
		#adding column if sum is one digit more than largest integer
		if (finalSum.to_s.size > args[0].to_s.size)
			colCount=colCount+1 
			startCol =1
		end
		numberTable = numSys_setTable(rowCount,colCount,args,shift)
		
		#for loop going from one's place to first column of number table-> int i=colCount-1 to 0
		(colCount-1).downto(0).each do |col|
			#calculating sum of numberTable[i][1] to numberTable[i][rowCount-2]
			sum = 0
			numberTable[0..(rowCount-2)].each{ |a| sum+=a[col].to_i }
			#Setting numberTable[i][rowCount-1]=ones digit of sum
			numberTable[rowCount-1][col] = sum.to_s.chars[-1].to_i
			#Setting numberTable[i-1][0] = remaining part of sum if i!=0
			numberTable[0][col-1] = numberTable[0][col-1].to_i+sum.to_s.chars[0..-2].join.to_i if col!=0
			#latexStringList << "Adding left most column i.e." numberTable[i][1] to numberTable[i][rowCount-2]
			@latexStringList << "Adding "+(col+1).to_s+"th column i.e. " + numberTable[col][1..(rowCount-2)].join(",") 
			#numberTableList << numberTable.numberTableToString()
			@numberTableList << numberTableToString(numberTable)
		#end
		end
	end
	def numSys_difference(*args)
		#check for shift for product
		shift= false
		if args[0] == true
			shift = true
			args = args[1..-1]
		end
		#Get number of columns of number table
		#Set number of row of number table
		colCount=args.max.to_s.size; rowCount=args.size+2;startColumn=0
		negative = false
		minuend=args[0];subtrahend=args[1]
		firstIndex = colCount - minuend.to_s.size
		#adding column if sum is one digit more than largest integer
		if (args[0]<args[1])
			colCount=colCount+1;negative=true; startColumn=1; firstIndex = firstIndex+1
			args = args.sort {|x,y| -(x <=> y)}
			@latexStringList << "As " +subtrahend.to_s+" is bigger than " +minuend.to_s+", we will subtract "+minuend.to_s+" from "+subtrahend.to_s+" and put a negative sign"
			minuend=args[0];subtrahend=args[1]
			@numberTableList << ""
		end
		numberTable = numSys_setTable(rowCount,colCount,args,shift)
		numberTable[rowCount-1][0]="-" if negative
		
		#for loop going from one's place to first column of number table-> int i=colCount-1 to 0
		(colCount-1).downto(startColumn).each do |col|
			#calculating sum of numberTable[i][1] to numberTable[i][rowCount-2]
			difference = 0
			minuendDigit = numberTable[1][col].to_i
			subtrahendDigit = numberTable[2][col].to_i
			if (minuendDigit < subtrahendDigit)
				#change minuend
				#carrying 1 from left and adding 10 to minuend
				numberTable[1][col] = 10+numberTable[1][col]
				remainingArray = numberTable[1][col..colCount]
				#change to left side after carry is taken
				carryNum = numberTable[1][startColumn..(col-1)].join.to_i
				carryNum=carryNum-1
				#get new carryNum array
				carryNumArray = carryNum.to_s.split('').map(&:to_i)
				blankCount = colCount-minuend.to_s.size
				numberTable[1] = Array.new(blankCount)+carryNumArray+remainingArray
				
				redo
				@latexStringList << "In "+(col+startColumn).to_s+"th column subtracting " +minuendDigit.to_s+" from " +subtrahendDigit.to_s+" and adding negative sign"
				
				
				
			
			#if minuedDigit < subtrahendDigit and it is not first element of minuend
			else 
				difference = minuendDigit-subtrahendDigit
				#Setting numberTable[i][rowCount-1]=ones digit of sum
				numberTable[rowCount-1][col] = difference
				#latexStringList << "In "+(col+1).to_s+"th column subtracting " +subtrahendDigit.to_s+" from " +minuendDigit.to_s
				@latexStringList << "In "+(col+startColumn).to_s+"th column subtracting " +subtrahendDigit.to_s+" from " +minuendDigit.to_s
			end

			#numberTableList << numberTable.numberTableToString()
			@numberTableList << numberTableToString(numberTable)
		#end
		end
	end
	def numSys_product(*args)
		#sort args list in decreasing order
		args = args.sort {|x,y| -(x <=> y)}
		multiplicand = args[0];multiplier=args[1];product = multiplicand*multiplier
		#Get number of columns of number table
		#Set number of row of number table
		colCount=product.to_s.size; rowCount=3+multiplier.to_s.size+1 
		multiplicandStart=colCount-multiplicand.to_s.size
		multiplierStart=colCount-multiplier.to_s.size
		
		shiftFlag = false
		numberTable = numSys_setTable(rowCount,colCount,args,shiftFlag)
		(colCount-1).downto(multiplierStart).each do |mult|
			shift = colCount-mult-1
			#for loop going from one's place to first column of number table-> int i=colCount-1 to 0
			(colCount-1).downto(multiplicandStart).each do |col|
				#calculating sum of numberTable[i][1] to numberTable[i][rowCount-2]
				product = numberTable[1][col].to_i*numberTable[2][mult].to_i
				#Setting numberTable[i][rowCount-1]=ones digit of sum
				numberTable[multiplier.to_s.size+shift][col-shift] = product.to_s.chars[-1].to_i + numberTable[0][col].to_i
				#Setting numberTable[i-1][0] = remaining part of sum if i!=0
				numberTable[0][col-1] = product.to_s.chars[0..-2].join.to_i  
				#If extra cary has come after starting index of multiplicand
				numberTable[multiplier.to_s.size+shift+1][col-shift-1] = product.to_s.chars[0..-2].join.to_i if col == multiplicandStart &&  numberTable[0][col-1].to_i >0
				#latexStringList << "Adding left most column i.e." numberTable[i][1] to numberTable[i][rowCount-2]
				@latexStringList << "Multiplying "+numberTable[1][col].to_s+" with "+numberTable[2][mult].to_s 
				#numberTableList << numberTable.numberTableToString()
				@numberTableList << numberTableToString(numberTable)
			#end
			end
		end
		numberTable.insert(3,Array.new(colCount))
		rowCount = rowCount+1

		#for loop going from one's place to first column of number table-> int i=colCount-1 to 0
		(colCount-1).downto(0).each do |col|
			#calculating sum of numberTable[i][1] to numberTable[i][rowCount-2]
			sum = 0
			numberTable[3..(rowCount-2)].each{ |a| sum+=a[col].to_i }
			#Setting numberTable[i][rowCount-1]=ones digit of sum
			numberTable[rowCount-1][col] = sum.to_s.chars[-1].to_i
			#Setting numberTable[i-1][0] = remaining part of sum if i!=0
			numberTable[3][col-1] = numberTable[0][col-1].to_i+sum.to_s.chars[0..-2].join.to_i if col!=0
			#latexStringList << "Adding left most column i.e." numberTable[i][1] to numberTable[i][rowCount-2]
			@latexStringList << "Adding "+(col+1).to_s+"th column i.e. " + numberTable[col][1..(rowCount-2)].join(",") 
			#numberTableList << numberTable.numberTableToString()
			@numberTableList << numberTableToString(numberTable)
		#end
		end
	end
	def numSys_divide(*args)

	end
	def factors(num)
	    1.upto(Math.sqrt(num)).select {|i| (num % i).zero?}.inject([]) do |f, i| 
	      f << i
	      f << num / i unless i == num / i
	      f
	  end.sort
	end
	def paired_up_factors(num)
	    a = factors(num)
	    l = a.length
	    if l % 2 == 0
	      a[0, l / 2].zip(a[- l / 2, l / 2].reverse)
	    else
	      a[0, l / 2].zip(a[- l / 2 + 1, l / 2].reverse) + [a[l / 2], a[l / 2]]
	    end
	  end
	def numSys_factor(*args)
		num = args[0]
		finalArray=[]
		factor_pair = paired_up_factors(num)
		factor_pair.each do |pair|
			@latexStringList << num.to_s+@eq.symbol+pair[0].to_s+@times.symbol+pair[1].to_s
			finalArray.concat(pair)
		end
		finalArray = finalArray.sort
		@latexStringList << "Thus the factors are "+finalArray.join(",")
	end
	def numSys_primeFactor(*args)
		num = args[0]
		primeList = Prime.prime_division(num)
	 	itemSeries="";product =1
		primeList.each do |pair|
			(1..pair[1]).each do |multiple|
		        itemSeries =itemSeries + pair[0].to_s+"x"
		        product = product*pair[0]
				@latexStringList << num.to_s+"="+itemSeries+(num/product).to_s if num !=product
			end
		end
	end
	def numSys_hcf(*args)
		factorList = Array.new(args.size)
		commonFactorList = []
		hcf=args[0]
		i=0
		args.each do |num|
			primeList = Prime.prime_division(num)
			hcf = hcf.gcd(num)
		 	factorList[i]=[]
			primeList.each do |pair|
				factorList[i].concat(Array.new(pair[1],pair[0]))
			end
			commonFactorList = commonFactorList & factorList[i]
			@latexStringList << num.to_s+"="+factorList[i].join("X")
			i = i+1
		end
		@latexStringList << "Clearly Common factors are "+commonFactorList.join(",")
		hcfList = Prime.prime_division(hcf)
		hcfList.each do |pair|
			@latexStringList << pair[0].to_s+" comes minimum of "+pair[1].to_s+" times"
		end
		@latexStringList << hcfList.join("X")+" = "+hcf.to_s


	end
	def numSys_lcm(*args)
		factorList = Array.new(args.size)
		commonFactorList = []
		lcm=args[0]
		i=0
		args.each do |num|
			primeList = Prime.prime_division(num)
			lcm = lcm.lcm(num)
		 	factorList[i]=[]
			primeList.each do |pair|
				factorList[i].concat(Array.new(pair[1],pair[0]))
			end
			commonFactorList = commonFactorList & factorList[i]
			@latexStringList << num.to_s+"="+factorList[i].join("X")
			i = i+1
		end
		@latexStringList << "Clearly Common factors are "+commonFactorList.join(",")
		lcmList = Prime.prime_division(lcm)
		lcmList.each do |pair|
			@latexStringList << pair[0].to_s+" comes maximum of "+pair[1].to_s+" times"
		end
		@latexStringList << lcmList.join("X")+" = "+lcm.to_s
	end
	def numSys_rearrangeDigit(*args)
		#Based on given number, rearrange the digits to get highest and lowest number possible
	end
	def numSys_expand(*args)
		#Expand number in indian system of numeration
	end
	def numSys_roundOff(*args)
		#Rounding number to nearest tenths, hundreds or appropriately
	end
	def numSys_sumEstimate(*args)
		#
	end
	def numSys_differenceEstimate(*args)
		#
	end
	def numSys_productEstimate(*args)
		#
	end
	def numSys_divideEstimate(*args)
		#
	end
	def numSys_operateUsingBracket(*args)
		#Doing operation by using brackets
	end
	def numSys_convertToRoman(*args)
		#Convert number to roman form
	end
	def numSys_nearby(*args)
		#write predecessor and successor
	end
	def numSys_multiple(*args)
		#Write 3 multiples fo numbers
	end
	def numSys_primeInRange(*args)
		#Write number if primes in a range of numbers (max and min)
	end
	def numSys_divisibilityTest(*args)
		#Divisiblity test of number based on 6,7,8,etc
	end
	def numSys_commonFactorList(*args)
		#Common factor list of list of numbers
	end
	def numSys_commonMultipleList(*args)
		#Common factor list of list of numbers
	end
	def numSys_compare(*args)

	end
	def numSys_indianSystemExpansion(*args)

	end
end