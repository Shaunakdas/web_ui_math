class Variable
	attr_accessor :symbol
	attr_accessor :substituteValue
	attr_accessor :substituteFlag
	
	def initialize(symbol)
		@symbol = symbol
		@substituteFlag = false
	end
	def initialize(symbol,substituteValue)
		@symbol = symbol
		@substituteValue = substituteValue
		@substituteFlag= false
	end
	def toLatexString
		@symbol
	end
	def setValue=(value)
		@substituteValue = value
	end
	def equals(other)
		if ((@substituteFlag == false) || (other.@substituteFlag == false))
			return (@symbol == other.@symbol);
		else
			return (@substituteValue == other.@substituteValue);
		end
	end
end