require_relative 'Term'
require_relative 'TermFraction'
require_relative 'Operator'
class Expression
	attr_accessor :expressionItemList, :exponent, :negative, :baseNegative
	def initialize()
		self.expressionItemList = []
		@exponent=1
		@negative=false
		@baseNegative = @negative
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
	
	def addExpressionItem(expressionItem)
		self.expressionItemList << expressionItem
	end
	def deleteItem(index)
		self.expressionItemList.delete_at(index)
	end
	def empty()
		self.expressionItemList =[]
	end
	def consistsVariable()
		variableFlag = false
		self.expressionItemList.each do |expressionItem|
			return true if expressionItem.getVariableList().length>0
		end
		return variableFlag
	end
	def consistsCoefficient()
		coeffFlag = false
		self.expressionItemList.each do |expressionItem|
			return true if expressionItem.consistsCoefficient()
		end
		return coeffFlag
	end
	def toLatexString
		latexString =""
		self.expressionItemList.each do |expressionItem|\
			if expressionItem.class.name != "Operator" && expressionItem.negativeFlag()
				latexString += "("+expressionItem.toLatexString()+")"
			else
				latexString += expressionItem.toLatexString()
			end
		end
		if exponentFlag() || negativeFlag()
			latexString="{("+latexString+")}"
			latexString="\\sqrt"+latexString if exponent == 0.5
		end
		exponentString =""
		exponentString ="^{"+@exponent.to_s+"}" if exponentFlag()&& @exponent != 0.5
		negativeString = ""
		negativeString = "-" if negativeFlag()
		return negativeString+latexString+exponentString;
	end
	def to_s
		toLatexString()
	end
	def negateExpression()
		negativeExpression = Marshal.load(Marshal.dump(self))
		negativeExpression.negative = true
		negativeExpression.negative = !@negative if @negative
		return negativeExpression
	end
	
	def getVariableList()
		variableList =[]
		self.expressionItemList.each do |expressionItem|
			variableList += expressionItem.getVariableList()
		end
		variableList = variableList.uniq{ |var| var.symbol}
		return variableList
	end
end