require_relative 'TermVariable'
require_relative 'TermCoefficient'
class Term
	attr_accessor :termItemList, :exponent, :negative
	def initialize()
		self.termItemList = []
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

	def addTermItem(termItem)
		self.termItemList << termItem
	end
	def addTermVariable(symbol,exponent,negative)
		termVar = TermVariable.new(symbol)
		termVar.setNegative(negative)
		termVar.setExponent(exponent)
		addTermItem(termVar)
	end
	def addTermCoefficient(base,exponent,negative)
		termCoeff = TermCoefficient.new(base)
		termCoeff.setNegative(negative)
		termCoeff.setExponent(exponent)
		addTermItem(termCoeff)
	end
	def consistsVariable()
		variableFlag = false
		self.termItemList.each do |termItem|
			return true if(termItem.class.name=="TermVariable")
		end
		return variableFlag
	end
	def consistsCoefficient()
		coeffFlag = false
		self.termItemList.each do |termItem|
			return true if(termItem.class.name=="TermCoefficient")
		end
		return coeffFlag
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
	def simplifyItemExponent()
		#Calculating individual item exponent values
		self.termItemList.each{ |termItem| termItem.simplifyExponent()}
	end
	def simplifyItemNegative()
		#Calculating individual item Negative Sign
		self.termItemList.each{ |termItem| termItem.simplifyNegative()}
	end
	def simplifyExponent()
		#Calculating value based on Term Exponent, bringin term exponnent on each item
		if exponentFlag()
			self.termItemList.each do |termItem|
				termItem.negative = (@exponent%2!=0)? true:false if termItem.negativeFlag()
				termItem.exponent = termItem.exponent*@exponent if termItem.exponentFlag()
			end
			@exponent=1
		end
	end
	def simplifyNegative()
		#Calculating Negative Sign based on negative sign of all items
		negativeCount = 0
		negativeCount+=1 if @negative
		self.termItemList.each do |termItem|
			negativeCount+=(termItem.negativeFlag()? 1:0)
			termItem.negative = false
		end
		@negative= ((negativeCount%2==0)? false:true)
	end
	def simplifyCoefficient()
		#Calculating Final TermCoefficient
		self.termItemList =[]
		groupedTermItemList = self.termItemList.group_by {|x| x.class.name}
		if groupedTermItemList["TermCoefficient"]
			finalTermCoeffItem=1
			termCoeffList = groupedTermItemList["TermCoefficient"] 
			termCoeffList.each{ |termCoeff| finalTermCoeffItem = finalTermCoeffItem*termCoeff}
			if(finalTermCoeffItem !=1)
				self.termItemList.addTermItem(TermCoefficient.new(finalTermCoeffItem))
				self.termItemList += groupedTermItemList["TermVariable"] if   groupedTermItemList["TermVariable"]
			end
		end
	end
	def simplifyVariable()
		#Calculating Final Variable List
		self.termItemList =[]
		self.termItemList += groupedTermItemList["TermCoefficient"] if groupedTermItemList["TermCoefficient"]
		groupedTermItemList = self.termItemList.group_by {|x| x.class.name}
		if groupedTermItemList["TermVariable"]
			termVarList = groupedTermItemList["TermVariable"] 
			termVarList.each do |termVar,index|
				((index+1)..(termVarList.length)) do |i|
					#Iterating throught the whole list after index to check for duplicates
					if(termVarList[index].variable.equals(termVarList[i].variable))
						#If variable is same at both the indexes
						#adding exponents of both termVariables
						termVarList[index].exponent += termVarList[i].exponent
						#deleting element at ith index
						termVarList.delete_at(i)
					end
				end
			end
			self.termItemList += termVarList
		end
	end

	def simplify()
		simplifyItemExponent()
		simplifyItemNegative()
		simplifyExponent()
		simplifyNegative()
		simplifyCoefficient()
		simplifyVariable()
	end
	def setValueList=(variableList)
		self.termItemList.each do |termItem|
			if termItem.class.name = "TermVariable"
				variableList.each do |variable|
					if termItem.variable.equals(variable)
						termCoeff = TermCoefficient.new(1)
						termCoeff.convertTermVariable(termItem,variable.substituteValue)
						termItem = termCoeff
					end
				end
				
			end
		end
	end
	def negateTerm()
		negativeTerm = Term.new(1)
		negativeTerm.termItemList = self.termItemList
		negativeTerm.exponent = @exponent if @exponent
		negativeTerm.negative = true
		negativeTerm.negative = !@negative if @negative
		return negativeTerm
	end
	def addCoefficientTerm(otherTerm)
		if (!consistsVariable() && !(otherTerm.consistsVariable()))
			#Contains only coefficient
			simplify()
			otherTerm.simplify()
			self.termItemList[0].base = -self.termItemList[0].base if self.termItemList[0].negative
			otherTerm.termItemList[0].base = -otherTerm.termItemList[0].base if otherTerm.termItemList[0].negative
			self.termItemList[0].base += otherTerm.termItemList[0].base
		end
	end
	def subtractCoefficientTerm(otherTerm)
		addCoefficientTerm(otherTerm.negateTerm())
	end
	def multiplyCoefficientTerm(otherTerm)
		term.termItemList << otherTerm.termItemList
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