class Fraction
	attr_accessor :numerator,:denominator
	def initialize(num,den)
		if(num.class.name == "Expression")
			@numerator = num
		else
			@numerator =Expression.new()
			term = Term.new()
			term.addTermItem(TermCoefficient.new(num))
			@numerator.addExpressionItem(term)
		end
		if(den.class.name == "Expression")
			@denominator = num
		else
			@denominator =Expression.new()
			term = Term.new()
			term.addTermItem(TermCoefficient.new(num))
			@denominator.addExpressionItem(term)
			@denominator.addTermItem(term)
		end
	end
	def addTermItem(termItem)
		self.expressionItemList << termItem
	end
	def toLatexString
		return "\\frac{"+@numerator.toLatexString()+"}{"+@denominator.toLatexString()+"}"
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