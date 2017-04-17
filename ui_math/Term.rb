require_relative 'TermVariable'
require_relative 'TermCoefficient'
class Term
	attr_accessor :termItemList, :exponent, :negative
	def initialize()
		self.termItemList = []
	end
	def setExponent(exponent)
		@exponent = exponent
	end
	def setNegative(negative)
		@negative = negative
	end
	def exponentFlag()
		return !(defined?(@exponent)).nil? && @exponent !=1
	end
	def negativeFlag()
		return !(defined?(@negative)).nil? && @negative ==true
	end
	def addTermItem(termItem)
		self.termItemList << termItem
	end
	def sortTermItem()
		groupedTermItemList = self.termItemList.group_by {|x| x.class.name}
		self.termItemList =[]
		self.termItemList += groupedTermItemList["TermCoefficient"] if groupedTermItemList["TermCoefficient"]
		self.termItemList += groupedTermItemList["TermVariable"] if   groupedTermItemList["TermVariable"]
	end
	def toLatexString
		self.sortTermItem()
		latexString =""
		self.termItemList.each do |termItem|
			if termItem.negativeFlag()
				latexString += "("+termItem.toLatexString()+")"
			else
				latexString += termItem.toLatexString()
			end
		end
		if exponentFlag()
			latexString="("+latexString+")"
		end
		exponentString =""
		exponentString ="^{"+@exponent.to_s+"}" if exponentFlag()
		negativeString = ""
		negativeString = "-" if negativeFlag()
		return negativeString+latexString+exponentString;
	end
	def setValue=(value)
		self.termItemList.each do |termItem|
			if termItem.class.name = "TermVariable"
				termCoeff = TermCoefficient.new(1)
				termCoeff.convertTermVariable(termItem,value)
				termItem = termCoeff
			end
		end
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