require_relative 'Variable'
class TermVariable
	include Comparable
	attr_accessor :variable, :exponent,:value,:negative
	def initialize(variableString)
		@variable = Variable.new(variableString)
		@exponent =1
		@negative=false
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
	def baseNegativeFlag()
		return false
	end
	def toLatexString
		exponentString =""
		exponentString ="^{"+@exponent.to_s+"}" if exponentFlag()
		negativeString = ""
		negativeString = "-" if negativeFlag()
		return negativeString+@variable.toLatexString()+exponentString
	end
	def negateTermItem()
		negativeTermVar = Marshal.load(Marshal.dump(self))
		negativeTermVar.negative= true
		negativeTermVar.negative = !@negative if @negative
		return negativeTermVar
	end
	def to_s
		toLatexString()
	end
	def simplifyExponent()
		
	end
	def simplifyNegative()
		
	end
	def calcValue(value)
		@value = value
		@value = value**@exponent if @exponent
	end
	def ==(other)
		if (defined?(@exponent)).nil?
			return @variable == (other.variable)
		else
			return (@variable == (other) && (@exponent==other.exponent))
		end
	end
	def getVariableList()
		return [@variable]
	end

end