require_relative '../ui_math/TermFraction'
require 'prime'
class AlgebraBasic
	attr_accessor :latexStringList
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
		@frac = "\\frac"
		@expo = "^"
	end
	def validateAlpha str
		chars = ('a'..'z').to_a + ('A'..'Z').to_a 
		!str.chars.detect {|ch| chars.include?(ch)}.nil?
	end
	def algBas_checkExpressionType(*args)
		exp_string= args[0];op_list=[];type=""
		#check for @eq sign
		#if exp_string has @eq-> Equation Pg6.238
		if exp_string.include? @eq.symbol
			type="equation"
			if validateAlpha exp_string
			#if exp_string has variable -> equation with variable 

			#else ->equation without variable
		#elsif exp_string has @lt,@gt-> Inequality Pg6.231
			type="inequality"

		#else exp_string doesn't has @eq-> Expression Pg6.231
			type="expression"
			#if exp_string has variable -> expression with variable 

			#else ->expression without variable Pg 6.233
		#end
		#check for @times,@div,@add,@subtract Pg6.233
			#op_list.add(symbol)
			#break exp_string into array divided by 4 operations
			#check for variable & coefficient in same term-> @times check

	end
	def algBas_solutionEquationBasic(*args)
		a=args[0];b=args[1];c=args[2];x=args[3];
		coeffA = TermCoefficient.new(a);coeffB = TermCoefficient.new(b);coeffC = TermCoefficient.new(c);varX = TermVariable(x)
		#Pg6.239
		exp=Expression.new()
		exp.expressionItemList = [decimal,@eq]
		answer = (b-c).to_f/a
	end
	def algBas_parseTerm(*args)
		input = args[0]

		#Check for exponent_sign
		exponent_hash = []
		#exponentSignIndexArray = Array of indices of exponent signs in input 
		exponentSignIndexArray = (0 ... input.length).find_all { |i| input[i,1] == '^' }
		for index in 0 ... exponentSignIndexArray.size
	    	expo_args = []; expo_args << args[0]; expo_args << (exponentSignIndexArray[index])
		  	p getExponentOfExponentIndex(*expo_args)
		  	p getBaseOfExponentIndex(*expo_args)
			# exponent_hash.add({:base => '',:exponent=> '', :base_positive => true})
		  	exponent_hash << ({:base => getBaseOfExponentIndex(*expo_args),:exponent=> getExponentOfExponentIndex(*expo_args), :base_positive => true})
		end

		#Check for fraction sign
		fraction_hash = []
		@frac = "\\frac" if(!@frac); fracCount=@frac.length
		#fractionIndexArray = Array of indices of fraction in input 
		fractionIndexArray = (0 ... input.length).find_all { |i| input[i,fracCount] == "\\frac" }
		for index in 0 ... fractionIndexArray.size
	    	num_args = []; num_args << args[0]
	    	num_args << (fractionIndexArray[index]+fracCount)
		  	p getNumOfFractionIndex(*num_args)
		  	den_args = []; den_args << args[0]
		  	den_args << (fractionIndexArray[index]+fracCount)+input[(fractionIndexArray[index]+fracCount)..-1].index('}')+1
		  	p getDenOfFractionIndex(*den_args)
		  	fraction_hash << ({:num => getNumOfFractionIndex(*num_args),:den=> getDenOfFractionIndex(*den_args)})
		end
		# Check for +,-,\\div,\\times. Divide expression into arrays of terms
		# Check for ({[ and make a nested list.
		#Check for alphabetical character
		variableArray = algBas_getVariableList(*args)
		#List alphabetical characters and their index in input text
		for index in 0 ... variableArray.size
		  
		end
		#For each character, 
		return MathElement
	end
	def getNumOfFractionIndex(*args)
		input = args[0]; num_start_index = args[1]
		subExp = input[(num_start_index)..-1]
		p subExp
		num_first_index = 1
		num_last_index = subExp.index('}')-1	 
		return subExp[num_first_index..num_last_index]
	end
	def getDenOfFractionIndex(*args)
		input = args[0]; den_start_index = args[1]
		subExp = input[(den_start_index)..-1]
		p subExp
		den_first_index = 1
		den_last_index = subExp.index('}')-1	 
		return subExp[den_first_index..den_last_index]
	end
	def getExponentOfExponentIndex(*args)
		input = args[0]; exponent_sign_index = args[1]
		subExp = input[(exponent_sign_index+1)..-1]
		exponent_first_index = 0; exponent_last_index = -1
		#switch(input[exponent_sign_index+1])
		case input[exponent_sign_index+1]
			#case "{":
			when "{"
			  #go from exponent_sign_index and find first "}" [=exponent_last_index+1]
			  exponent_last_index = subExp.index('}')-1
			  exponent_first_index = 1
			#case "(":
			when "("
  			#go from exponent_sign_index and find first ")" [=exponent_last_index+1]
  			exponent_last_index = subExp.index(')')-1
  			exponent_first_index = 1
			#case alphabetic character:
			when 'a'..'z'
			  exponent_last_index = exponent_first_index
			#case numeric:
			when '0'..'9'
			  #go from exponent_sign_index and find first non-numeric [=exponent_last_index+1]
			  exponent_last_index = subExp.index(/\D/)-1
			else
		end
		return subExp[exponent_first_index..exponent_last_index]
	end
	def getBaseOfExponentIndex(*args)
		input = args[0]; exponent_sign_index = args[1]
		subExp = input[0..(exponent_sign_index-1)]
		base_first_index = 0; base_last_index = -1
		#switch(input[exponent_sign_index+1])
		case input[exponent_sign_index-1]
			#case "}":
			when "}"
			  #go back from exponent_sign_index and find first "{" [=base_first_index]
			  base_first_index = subExp.rindex('{')+1
			  base_last_index = -2
			#case ")":
			when ")"
  			#go back from exponent_sign_index and find first "(" [=base_first_index]
  			base_first_index = subExp.rindex('(')+1
  			base_last_index = -2
			#case alphabetic character:
			when 'a'..'z'
			  base_first_index = base_last_index
			#case numeric:
			when '0'..'9'
			  #go back from exponent_sign_index and find first non-numeric [=base_first_index-1]
			  base_first_index = subExp.rindex(/\D/)+1
			else
		end
		return subExp[base_first_index..base_last_index]
	end
	def algBas_getVariableList(*args)
		input = args[0]
		variableArray = []

	end
	def algBas_getExponentOfBase(*args)
		input = args[0]; base = args[1]
		#Get index of base in string of input

	end
end