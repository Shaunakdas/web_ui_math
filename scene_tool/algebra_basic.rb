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
end