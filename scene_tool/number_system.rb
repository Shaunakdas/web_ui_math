require_relative '../ui_math/TermFraction'
require 'prime'
require 'humanize'
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
	def name(a)
		case a
		when 10
			return "tens"
		when 100
			return "hundreds"
		when 1000
			return "thousands"
		else
			return "tens"
		end
	end
	def to_words(num)
	  numbers_to_name = {
	      10000000 => "crore",
	      100000 => "lakh",
	      1000 => "thousand",
	      100 => "hundred",
	      90 => "ninety",
	      80 => "eighty",
	      70 => "seventy",
	      60 => "sixty",
	      50 => "fifty",
	      40 => "forty",
	      30 => "thirty",
	      20 => "twenty",
	      19=>"nineteen",
	      18=>"eighteen",
	      17=>"seventeen", 
	      16=>"sixteen",
	      15=>"fifteen",
	      14=>"fourteen",
	      13=>"thirteen",              
	      12=>"twelve",
	      11 => "eleven",
	      10 => "ten",
	      9 => "nine",
	      8 => "eight",
	      7 => "seven",
	      6 => "six",
	      5 => "five",
	      4 => "four",
	      3 => "three",
	      2 => "two",
	      1 => "one"
	    }

	  log_floors_to_ten_powers = {
	    0 => 1,
	    1 => 10,
	    2 => 100,
	    3 => 1000,
	    4 => 1000,
	    5 => 100000,
	    6 => 100000,
	    7 => 10000000
	  }

	  num = num.to_i
	  return '' if num <= 0 or num >= 100000000

	  log_floor = Math.log(num, 10).floor
	  ten_power = log_floors_to_ten_powers[log_floor]

	  if num <= 20
	    numbers_to_name[num]
	  elsif log_floor == 1
	    rem = num % 10
	    [ numbers_to_name[num - rem], to_words(rem) ].join(' ')
	  else
	    [ to_words(num / ten_power), numbers_to_name[ten_power], to_words(num % ten_power) ].join(' ')
	  end
	end
	def roman(n)
		romanNumbers = {
		    1000 => "M",  
		     900 => "CM",  
		     500 => "D",  
		     400 => "CD",
		     100 => "C",  
		      90 => "XC",  
		      50 => "L",  
		      40 => "XL",  
		      10 => "X",  
		        9 => "IX",  
		        5 => "V",  
		        4 => "IV",  
		        1 => "I",  
		  }
	    roman = ""
	    romanNumbers.each do |value, letter|
	      roman << letter*(n / value)
	      n = n % value
	    end
	    return roman
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
			commonFactorList = commonFactorList && factorList[i]
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
			commonFactorList = commonFactorList && factorList[i]
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
		if args.size==1
			#We were provided one number and we have to find the highest and lowest number formed by rearranging digits of given number
			digitArray = args[0].to_s.split('').map(&:to_i)
			@latexStringList << "Digits present in #{args[0]} are #{digitArray.join(",")}"
		else
			#We were provided list of digits and we have to find the highest and lowest number formed by rearranging digits
			digitArray = args
		end
		@latexStringList << "We have to create greatest and smallest number by rearranging #{digitArray.join(",")}"
		digitArray.sort!
		@latexStringList << "Above List can be rearranged in increasing order as #{digitArray.join(",")}"
		@latexStringList << "Hence the smallest number possible will be #{digitArray.join("").to_i.to_s}"
		digitArray.reverse!
		@latexStringList << "And the same List can be rearranged in decreasing order as #{digitArray.join(",")}"
		@latexStringList << "Hence the greatest number possible will be #{digitArray.join("").to_i.to_s}"
	end
	def numSys_roundOff(*args)
		#Rounding number to nearest tenths, hundreds or appropriately
		num=args[0]; nearest=args[1]
		answer = ((num.to_f/nearest).round)*nearest
		ceil = ((num.to_f/nearest).ceil)*nearest
		floor = ((num.to_f/nearest).floor)*nearest
		@latexStringList << "#{num} lies between #{ceil} and #{floor}."
		@latexStringList << "It is nearer to #{answer}, so it is rounded off as #{answer}"
	end
	def numSys_roundOffSmall(*args)
		#Rounding number to nearest tenths, hundreds or appropriately
		num=args[0] 
		nearest= 10**((Math.log10(num)).to_i)
		nearest=args[1] if args.size==2
		answer = ((num.to_f/nearest).round)*nearest
		@latexStringList << "Approximating to nearest #{name(nearest)}, #{num} rounds off to #{answer}"
	end
	def numSys_sumEstimate(*args)
		newArr=[]
		args.each do |num|
			numSys_roundOffSmall(num)
			nearest= 10**((Math.log10(num)).to_i)
			newArr << ((num.to_f/nearest).round)*nearest
		end
		numSys_sum(*newArr)
	end
	def numSys_differenceEstimate(*args)
		
		newArr=[]
		args.each do |num|
			numSys_roundOffSmall(num)
			nearest= 10**((Math.log10(num)).to_i)
			newArr << ((num.to_f/nearest).round)*nearest
		end
		numSys_difference(*newArr)
	end
	def numSys_productEstimate(*args)
		newArr=[]
		args.each do |num|
			numSys_roundOffSmall(num)
			nearest= 10**((Math.log10(num)).to_i)
			newArr << ((num.to_f/nearest).round)*nearest
		end
		numSys_product(*newArr)
	end
	def numSys_divideEstimate(*args)
		newArr=[]
		args.each do |num|
			numSys_roundOffSmall(num)
			nearest= 10**((Math.log10(num)).to_i)
			newArr << ((num.to_f/nearest).round)*nearest
		end
		numSys_divide(*newArr)
	end
	def numSys_operateUsingBracket(*args)
		#Doing operation by using brackets
	end
	def numSys_convertToRoman(*args)
		#Convert number to roman form
		romanNumbers = {
		    1000 => "M",  
		     900 => "CM",  
		     500 => "D",  
		     400 => "CD",
		     100 => "C",  
		      90 => "XC",  
		      50 => "L",  
		      40 => "XL",  
		      10 => "X",  
		        9 => "IX",  
		        5 => "V",  
		        4 => "IV",  
		        1 => "I",  
		  }
		n=args[0]
	    roman = "";digitArr = []; romanArr = []
	    romanNumbers.each do |value, letter|
	    	if (n/value) > 0 
	      		roman << letter*(n / value)
	      		romanArr << "("+([letter]*(n/value)).join('+').to_s+")"
	      		digitArr << "("+([value]*(n/value)).join('+').to_s+")"
	      	end
	      	n = n % value
	    end
	    @latexStringList << "#{args[0]} = #{digitArr.join('+').to_s} "
	    @latexStringList << "#{args[0]} = #{romanArr.join('+').to_s} "
		@latexStringList << "Roman form of #{args[0]} is #{roman(args[0])}"
	end
	def numSys_nearby(*args)
		#write predecessor and successor
		@latexStringList << "To get a successor of any natural number, you can add 1 to that number. Hence Successor of #{args[0]} is #{args[0]+1}"
		@latexStringList << "To get a predecessor of any natural number, you can subtract 1 from that number. Hence Predecessor of #{args[0]} is #{args[0]-1}"
	end
	def numSys_multiple(*args)
		#Write 3 multiples of numbers
		@latexStringList << "The required multiples are"
		multipleText=[];multipleArray=[]
		for i in 1..args[1]
			multipleText << "#{args[0]}\\times#{i}=#{args[0]*i}"
			multipleArray << args[0]*i
		end
		@latexStringList << multipleText.join(",").to_s
		@latexStringList << multipleArray.join(",").to_s
	end
	def numSys_primeInRange(*args)
		#Write number if primes in a range of numbers (max and min)
		args.sort!
		numArr = []
		Prime.each(args[1]) do |prime|
		  numArr << prime  
		end
		Prime.each(args[0]) do |prime|
		  numArr.delete(prime)  
		end
		@latexStringList << "Primes between #{args[0]} and #{args[1]} are "+numArr.join(",").to_s
	end
	def numSys_divisibilityTest(*args)
		#Divisiblity test of number based on 6,7,8,etc
		numArr = args[0].to_s.chars.map(&:to_i)
		case args[1]
		when 10
			@latexStringList << "if a number has 0 in the ones place then it is divisible by 10."
			ones=numArr[-1]
			@latexStringList << "Ones digit of #{args[0]} is #{ones}"
		when 5
			@latexStringList << "a number which has either 0 or 5 in its ones place is divisible by 5"
			ones=numArr[-1]
			@latexStringList << "Ones digit of #{args[0]} is #{ones}"
		when 2
			@latexStringList << "a number is divisible by 2 if it has any of the digits 0, 2, 4, 6 or 8 in its ones place."
			ones=numArr[-1]
			@latexStringList << "Ones digit of #{args[0]} is #{ones}"
		when 3
			@latexStringList << "if the sum of the digits is a multiple of 3, then the number is divisible by 3."
			sum= numArr.inject(0){|sum,x| sum + x }
			@latexStringList << "sum of digits of #{args[0]} is #{sum}"
		when 6
			@latexStringList << "if a number is divisible by 2 and 3 both then it is divisible by 6 also."
			numSys_divisibilityTest(args[0],2)
			numSys_divisibilityTest(args[0],3)
		when 4
			@latexStringList << "a number with 3 or more digits is divisible by 4 if the number formed by its last two digits (i.e. ones and tens) is divisible by 4."
			@latexStringList << "number formed by its last two digits is #{numArr[-2]}#{numArr[-1]}"
		when 8
			@latexStringList << "a number with 4 or more digits is divisible by 8, if the number formed by the last three digits is divisible by 8."
			@latexStringList << "number formed by its last three digits is #{numArr[-3]}#{numArr[-2]}#{numArr[-1]}"
		when 9
			@latexStringList << "if the sum of the digits of a number is divisible by 9, then the number itself is divisible by 9."
			sum= numArr.inject(0){|sum,x| sum + x }
			@latexStringList << "sum of digits of #{args[0]} is #{sum}"
		when 11
			@latexStringList << "find the difference between the sum of the digits at odd places (from the right) and the sum of the digits at even places (from the right) of the number. If the difference is either 0 or divisible by 11, then the number is divisible by 11."
			oddSum=0;evenSum=0;
			numArr.each_with_index do |digit,i|
				oddSum = oddSum+digit if i%2 !=0
				evenSum = evenSum +digit if 1%2 == 0 
			end
			@latexStringList << "sum of the digits at odd places is #{oddSum} and sum of the digits at even places is #{evenSum}" if numArr.size%2==0
			@latexStringList << "sum of the digits at odd places is #{evenSum} and sum of the digits at even places is #{oddSum}" if numArr.size%2!=0
		else
			@latexStringList << "if a number has 0 in the ones place then it is divisible by 10."
		end
		answer = (args[0]%args[1] == 0)? "":" not"
		@latexStringList << "Hence #{args[0]} is#{answer} divisible by #{args[1]}"
	end
	def numSys_commonFactorList(*args)
		#Common factor list of list of numbers
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
			commonFactorList = commonFactorList && factorList[i]
			@latexStringList << num.to_s+"="+factorList[i].join("X")
			i = i+1
		end
		@latexStringList << "Clearly Common prime factors are "+commonFactorList.join(",")
	end
	def numSys_commonMultipleList(*args)
		#Common factor list of list of numbers
		factorList = Array.new(args.size)
		commonFactorList = []; commonMultipleList=[]
		lcm=args[0]
		i=0
		args.each do |num|
			primeList = Prime.prime_division(num)
			lcm = lcm.lcm(num)
		 	factorList[i]=[]
			primeList.each do |pair|
				factorList[i].concat(Array.new(pair[1],pair[0]))
			end
			commonFactorList = commonFactorList && factorList[i]
			@latexStringList << num.to_s+"="+factorList[i].join("X")
			i = i+1
		end
		# @latexStringList << "Common prime factors are "+commonFactorList.join(",")
		@latexStringList << "Common multiples of this list are #{lcm},#{2*lcm} and #{3*lcm}"
	end
	def numSys_compare(*args)

	end
	def numSys_indianSystemExpansion(*args)
		expand = args[0].to_s.gsub(/(\d+?)(?=(\d\d)+(\d)(?!\d))(\.\d+)?/, "\\1,")
		@latexStringList << "After adding comma at the right places according to indian numbering system, #{args[0]} = #{expand}"
		@latexStringList << "Indian form of numeration for #{args[0]} is #{to_words(args[0])}"
	end

	def numSys_internationalSystemExpansion(*args)
		expand = args[0].to_s.reverse.scan(/\d{3}|.+/).join(",").reverse
		@latexStringList << "After adding comma at the right places according to indian numbering system, #{args[0]} = #{expand}"
		@latexStringList << "Indian form of numeration for #{args[0]} is #{args[0].humanize}"
	end
end