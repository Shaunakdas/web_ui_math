class Variable
	include Comparable
	attr_accessor :symbol,:substituteValue,:substituteNegative
	
	def initialize(symbol)
		@symbol = symbol
	end
	def toLatexString
		@symbol.to_s
	end
	def <=>(another)
		self.symbol <=> another.symbol
	end
	def to_s
		toLatexString()
	end
	def setValue(value)
		@substituteValue = value
		@substituteNegative = false
		@substituteNegative = true if value < 0
	end
	# def ==(other)
	# 	if (defined?(@substituteValue)).nil?
	# 		return (@substituteValue == other.substituteValue);
	# 	else
	# 		return (@symbol == other.symbol);
	# 	end
	# end
end