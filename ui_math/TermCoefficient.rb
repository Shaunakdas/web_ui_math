require_relative 'TermVariable'
class TermCoefficient
	attr_accessor :base,:baseNegative, :exponent, :negative
	def initialize(base)
		if base<0
			@baseNegative  = (base<0)? true:false
		end
		@base = base.abs
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
		return !(defined?(@baseNegative)).nil? && @baseNegative ==true
	end
	def toLatexString
		exponentString =""
		exponentString ="^{"+@exponent.to_s+"}" if exponentFlag()
		negativeString = ""
		negativeString = "-" if negativeFlag()
		baseString = @base.to_s
		if baseNegativeFlag()
			baseString  = (baseNegativeFlag()? "-":"+")+baseString
			if negativeFlag() || exponentFlag()
				baseString="("+baseString+")"
			end
		end
		return negativeString+baseString+exponentString;
	end
	def simplifyExponent()
		if baseNegativeFlag()
			@baseNegative = (@exponent%2!=0)? true:false;
		end
		@base = @base**@exponent
		@exponent =1
	end
	def simplifyBracket()
		if baseNegativeFlag() && negativeFlag()
			@baseNegative = !@baseNegative
			@negative = !@negative
		end
	end
	def convertTermVariable(termVar,substituteValue)
		initialize(substituteValue)
		@exponent = termVar.exponent if termVar.exponentFlag()
		@negative = termVar.negative if termVar.negativeFlag()

	end
	def equals(other)
		if ((defined?(@exponent)).nil? && (defined?(other.exponent)).nil?)
			return (@base == other.base)
		else
			return ((@base == other.base) && (@exponent==other.exponent))
		end
	end
	def getVariableList()
		return []
	end
end