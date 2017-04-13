class Operator
	attr_accessor :symbol
	def initialize(symbol)
		@symbol = symbol
	end
	def toLatexString
		@symbol
	end
	def equals(other)
		return @symbol == other.symbol
	end
	def getVariableList()
		return []
	end
end