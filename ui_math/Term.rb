class Term
	attr_accessor :termItemList
	def initialize(baseValue)
		self.termItemList = []
	end
	def initialize(termItem)
		self.termItemList = [termItem]
	end
	def addTermItem(termItem)
		self.termItemList << termItem
	end
	def toLatexString
		latexString =""
		self.termItemList.each do |termItem|
			latexString += termItem.toLatexString()
		end
	end
	def setValue=(value)
		@substituteValue = value
	end
	def equals(other)
	end
	def getVariableList()
		variableList =[]
		self.termItemList.each do |termItem|
			variableList += termItem.getVariableList()
		end
		variableList = variableList.uniq
		return variableList
	end
end