class Expression
	attr_accessor :expressionItemList
	def initialize()
		self.expressionItemList = []
	end
	def addExpressionItem(termItem)
		self.expressionItemList << expressionItem
	end
	def toLatexString
		latexString =""
		self.expressionItemList.each do |termItem|
			latexString += termItem.toLatexString()
		end
		return latexString
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