require_relative 'Expression'
require_relative 'Operator'
class Expression
	attr_accessor :expressionItemList, :exponent, :negative
	def initialize()
		self.expressionItemList = []
		@exponent=1
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
	def consistsVariable()
		variableFlag = false
		self.expressionItemList.each do |expressionItem|
			return true if expressionItem.consistsVariable()
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
	def sortExpressionItem()
		groupedExpressionItemList = self.expressionItemList.group_by {|x| x.consistsVariable().to_s}
		self.expressionItemList =[]
		self.expressionItemList += groupedExpressionItemList["true"] if   groupedExpressionItemList["true"]
		self.expressionItemList += groupedExpressionItemList["false"] if groupedExpressionItemList["false"]
		end
	def toLatexString
		self.sortExpressionItem()
		latexString =""
		self.expressionItemList.each do |expressionItem|
			if expressionItem.negativeFlag()
				latexString += "("+expressionItem.toLatexString()+")"
			else
				latexString += expressionItem.toLatexString()
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
	def to_s
		toLatexString()
	end
	def negateExpression()
		negativeExpression = Expression.new(1)
		negativeExpression.expressionItemList = @base.expressionItemList
		negativeExpression.exponent = @exponent if @exponent
		negativeExpression.negative = true
		negativeExpression.negative = !@negative if @negative
		return negativeExpression
	end
	
	def ==(other)
	end
	def getVariableList()
		variableList =[]
		self.expressionItemList.each do |expressionItem|
			variableList += expressionItem.getVariableList()
		end
		variableList = variableList.uniq
		return variableList
	end
end