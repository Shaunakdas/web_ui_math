class Operator
	attr_accessor :symbol
	def initialize(symbol)
		@symbol = symbol
	end
	def toLatexString
		@symbol
	end
	def to_s
		toLatexString()
	end
	def ==(other)
		return @symbol == other.symbol
	end
	def getVariableList()
		return []
	end

	def consistsCoefficient()
		return false
	end
	def consistsVariable()
		return false
	end
end