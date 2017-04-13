class Expression
	attr_accessor :expressionItemList
	def initialize(baseValue)
		self.expressionItemList = []
	end
	def initialize(termItem)
		self.expressionItemList = [termItem]
	end
	def addTermItem(termItem)
		self.expressionItemList << termItem
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