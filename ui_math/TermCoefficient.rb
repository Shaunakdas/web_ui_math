class TermCoefficient
	attr_accessor :base, :exponent
	def initialize(baseValue)
		@base = baseValue
	end
	def initialize(baseValue,exponent)
		@base = baseValue
		@exponent = exponent
	end
	def toLatexString
		if (defined?(@exponent)).nil?
			return @base.toLatexString()
		else
			return @base.toLatexString()+"^{"+@exponent.to_s+"}"
		end
	end
	def setValue=(value)
		@substituteValue = value
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