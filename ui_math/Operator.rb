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
	def opposite()
		puts case @symbol
		when "+"
			return Operator.new("-")
		when "-"
			return Operator.new("+")
		when "\\times"
			return Operator.new("\\div")
		when "\\div"
			return Operator.new("\\times")
		when "("
			return Operator.new(")")
		when ")"
			return Operator.new("(")
		when "{"
			return Operator.new("}")
		when "}"
			return Operator.new("{")
		when "["
			return Operator.new("]")
		when "]"
			return Operator.new("[")
		when "<"
			return Operator.new(">")
		when ">"
			return Operator.new("<")
		else
			return Operator.new("_")
		end
			
	end
end