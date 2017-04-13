class Fraction
	attr_accessor :numerator,:denominator
	def initialize(value)
		@numerator = new Expression(value)
		@denominator = new Expression(1)
	end
	def initialize(num,den)
		if(num.class.name == "Expression")
			@numerator = num
		else
			@numerator = new Expression(num)
		end
		if(den.class.name == "Expression")
			@denominator = num
		else
			@denominator = new Expression(den)
		end
	end
	def addTermItem(termItem)
		self.expressionItemList << termItem
	end
	def toLatexString
		return "\\frac{"+@numerator.toLatexString()+"}{"+@denominator.toLatexString()
	end
	def setValue=(value)
	end
	def equals(other)
	end
	def getVariableList()
		variableList =[]
		self.expressionItemList.each do |termItem|
			variableList += termItem.getVariableList()
		end
		variableList = variableList.uniq
		return variableList
	end
end