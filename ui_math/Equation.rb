class Equation
	attr_accessor :leftExpression,:rightExpression,:middleOperator
	def initialize(left,right)
		if(left.class.name == "Expression")
			@leftExpression = left
		else
			@leftExpression = new Expression(left)
		end
		if(right.class.name == "Expression")
			@rightExpression = left
		else
			@rightExpression = new Expression(right)
		end
		@middleOperator = new Operator("=")

	end
	def addTermItem(termItem)
		self.expressionItemList << termItem
	end
	def toLatexString
		return @leftExpression.toLatexString()+@middleOperator.toLatexString()+@rightExpression.toLatexString()
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