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
	def addSimpleFraction(num,den,exponent,negative)
		simpleFrac  = SimpleFraction.new(num,den)
		simpleFrac.setNegative(negative)
		simpleFrac.setExponent(exponent)
		addTermItem(simpleFrac)
	end
	def addTermCoefficient(base,exponent,negative)
		termCoeff = TermCoefficient.new(base)
		termCoeff.setNegative(negative)
		termCoeff.setExponent(exponent)
		addTermItem(termCoeff)
	end
	def consistsVariable()
		self.termItemList.each do |termItem|
			return true if(termItem.class.name=="TermVariable")
		end
		return false
	end
	def consistsCoefficient()
		self.termItemList.each do |termItem|
			return true if(termItem.class.name=="TermCoefficient")
		end
		return false
	end
	def consistsSimpleFraction()
		self.termItemList.each do |termItem|
			return true if(termItem.class.name=="SimpleFraction")
		end
		return false
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
			if termItem.negativeFlag() || termItem.baseNegativeFlag()
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
	def to_s
		toLatexString()
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
		#Calculating value based on Term Exponent, bringing term exponnent on each item
		if exponentFlag()
			self.termItemList.each do |termItem|
				termItem.negative = (@exponent%2!=0)? true:false if termItem.negativeFlag()
				termItem.exponent = termItem.exponent*@exponent 
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
		groupedTermItemList = self.termItemList.group_by {|x| x.class.name}
		self.termItemList =[]
		if groupedTermItemList["TermCoefficient"]
			finalTermCoeffItem=1
			termCoeffList = groupedTermItemList["TermCoefficient"] 
			
			termCoeffList.each{ |termCoeff| finalTermCoeffItem = finalTermCoeffItem*termCoeff.calcFinalValue()}
			
			if(groupedTermItemList["TermVariable"])
				self.addTermItem(TermCoefficient.new(finalTermCoeffItem)) if finalTermCoeffItem !=1
				self.termItemList += groupedTermItemList["TermVariable"] if   groupedTermItemList["TermVariable"]
			else
				self.addTermItem(TermCoefficient.new(finalTermCoeffItem))
			end
		end
	end
	def simplifyVariable()
		#Calculating Final Variable List
		groupedTermItemList = self.termItemList.group_by {|x| x.class.name}
		self.termItemList =[]
		self.termItemList += groupedTermItemList["TermCoefficient"] if groupedTermItemList["TermCoefficient"]
		if groupedTermItemList["TermVariable"]
			termVarList = groupedTermItemList["TermVariable"] 
			termVarList.each_with_index do |termVar,indexer|
				((indexer+1)..(termVarList.length-1)).each do |i|
					#Iterating throught the whole list after index to check for duplicates
					if(termVarList[indexer].variable == (termVarList[i].variable))
						#If variable is same at both the indexes
						#adding exponents of both termVariables
						termVarList[indexer].exponent += termVarList[i].exponent
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
	def setValueList(variableList)
		self.termItemList.each_with_index do |termItem,index|
			if termItem.class.name == "TermVariable"
				variableList.each do |variable|
					if termItem.variable == (variable)
						termCoeff = TermCoefficient.new(1)
						termCoeff.convertTermVariable(termItem,variable.substituteValue)
						self.termItemList.delete_at(index)
						self.termItemList.insert(index,termCoeff)
					end
				end
				
			end
		end
	end
	def negateTerm()
		puts "Negative"+@negative.to_s
		negativeTerm = Marshal.load(Marshal.dump(self))
		negativeTerm.negative= true
		negativeTerm.negative = !@negative if @negative
		return negativeTerm
	end
	def addCoefficientTerm(otherTerm)
		if (!consistsVariable() && !(otherTerm.consistsVariable()))
			#Contains only coefficient
			selfRef = Marshal.load(Marshal.dump(self))
			selfRef.simplify()
			otherTermRef = Marshal.load(Marshal.dump(otherTerm))
			otherTermRef.simplify()
			selfRef.bringNegativeInside()
			otherTermRef.bringNegativeInside()
			selfRef.termItemList[0] = selfRef.termItemList[0].add(otherTermRef.termItemList[0])
			selfRef.simplify()
			return selfRef
		end
	end
	def bringNegativeInside()
		if self.negativeFlag()
			self.termItemList.each_with_index do |termItem,index|
				self.termItemList[index] = termItem.negateTermItem()
			end
			self.negative = false
		end
	end
	def subtractCoefficientTerm(otherTerm)
		return addCoefficientTerm(otherTerm.negateTerm())
	end
	def multiplyCoefficientTerm(otherTerm)
		selfRef = Marshal.load(Marshal.dump(self))
		selfRef.simplify()
		selfRef.bringNegativeInside()
		otherTermRef = Marshal.load(Marshal.dump(otherTerm))
		otherTermRef.simplify()
		otherTermRef.bringNegativeInside()
		selfRef.termItemList = selfRef.termItemList + otherTermRef.termItemList
		selfRef.simplifyCoefficient()
		return selfRef
	end
	
	def ==(other)
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