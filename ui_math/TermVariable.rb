require_relative 'Variable'
class TermVariable
	include Comparable
	attr_accessor :variable, :exponent,:value,:negative
	def initialize(variableString)
		@variable = Variable.new(variableString)
		@exponent =1
	end
	def <=>(another)
	    @variable.symbol <=> another.variable.symbol
	end
	def setExponent(exponent)
		@exponent = exponent
	end
	def setNegative(negative)
		@negative = negative
	end
	def exponentFlag()
		return !(defined?(@exponent)).nil? && @exponent !=1
	end
	def negativeFlag()
		return !(defined?(@negative)).nil? && @negative ==true
	end
	def toLatexString
		exponentString =""
		exponentString ="^{"+@exponent.to_s+"}" if exponentFlag()
		negativeString = ""
		negativeString = "-" if negativeFlag()
		return negativeString+@variable.toLatexString()+exponentString
	end
	def simplifyExponent()
		
	end
	def simplifyNegative()
		
	end
	def calcValue(value)
		@value = value
		@value = value**@exponent if @exponent
	end
	def equals(other)
		if (defined?(@exponent)).nil?
			return @variable.equals(other.variable)
		else
			return (@variable.equals(other) && (@exponent==other.exponent))
		end
	end
	def getVariableList()
		return [@variable]
	end

end