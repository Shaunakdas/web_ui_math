class TermVariable
	attr_accessor :variableComponent, :exponent
	def initialize(variableString)
		@variableComponent = new Variable(variableString)
	end
	def initialize(variableString,exponent)
		@variableComponent = new Variable(variableString)
		@exponent = exponent
	end
	def toLatexString
		if (defined?(@exponent)).nil?
			return @variableComponent.toLatexString()
		else
			return @variableComponent.toLatexString()+"^{"+@exponent.to_s+"}"
		end
	end
	def setValue=(value)
		@substituteValue = value
	end
	def equals(other)
		if (defined?(@exponent)).nil?
			return @variableComponent.equals(other.variableComponent)
		else
			return (@variableComponent.equals(other) && (@exponent==other.exponent))
		end
	end
	def getVariableList()
		return [variableComponent]
	end
end