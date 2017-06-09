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
		# exponent_hash.add({:base => '',:exponent=> '', :base_positive => true})
		#exponentSignIndexArray = Array of indices of exponent signs in input 
		for index in 0 ... exponentSignIndexArray.size
		  expo_args = args; expo_args.add(exponentSignIndexArray[index])
		  base = getBaseOfExponentIndex(*expo_args)
		  exponent = getExponentOfExponentIndex(*expo_args)
		end
		#Check for alphabetical character
		variableArray = algBas_getVariableList(*args)
		#List alphabetical characters and their index in input text
		for index in 0 ... variableArray.size
		  
		end
		#For each character, 
		return MathElement
	end
	def getExponentOfExponentIndex(*args)
		input = args[0]; exponent_sign_index = args[1]
		exponent_first_index = exponent_sign_index+1; exponent_last_index = 0
		#switch(input[exponent_sign_index+1])
			#case "{":
			#go back from exponent_sign_index and find first "}" [=exponent_last_index+1]
			exponent_first_index = exponent_sign_index+2;
			#case "(":
			#go back from exponent_sign_index and find first ")" [=exponent_last_index+1]
			exponent_first_index = exponent_sign_index+2;
			#case alphabetic character:
			#exponent_last_index = exponent_sign_index+1
			#case numeric:
			#go back from exponent_sign_index and find first non-numeric [=exponent_sign_index+!]
		#end
	end
	def getBaseOfExponentIndex(*args)
		input = args[0]; exponent_sign_index = args[1]
		base_first_index = 0; base_last_index = exponent_sign_index-1
		#switch(input[exponent_sign_index-1])
			#case "}":
			#go back from exponent_sign_index and find first "{" [=base_first_index]
			#case ")":
			#go back from exponent_sign_index and find first "(" [=base_first_index]
			#case alphabetic character:
			#base_first_index = exponent_sign_index-2
			#case numeric:
			#go back from exponent_sign_index and find first non-numeric [=base_first_index-1]
		#end
		return input.substring(base_first_index,base_last_index)
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