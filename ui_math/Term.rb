require_relative 'TermVariable'
require_relative 'TermCoefficient'
class Term
	attr_accessor :termItemList, :exponent, :negative, :baseNegative
	def initialize()
		self.termItemList = []
		@exponent=1
		@negative = false
		@baseNegative= @negative
	end
	def setExponent(exponent)
		@exponent = exponent
	end
	def setNegative(negative)
		@negative = negative
		@baseNegative = negative
	end
	def exponentFlag()
		return !(defined?(@exponent)).nil? && @exponent !=1
	end
	def negativeFlag()
		return !(defined?(@negative)).nil? && @negative ==true
	end

	def cloneForOperation()
		selfRef = Marshal.load(Marshal.dump(self))
		return selfRef
	end
	def addTermItem(termItem)
		self.termItemList << termItem
	end
	def [](index)
		return self.termItemList[index]
	end
	def []=(index,value)
		self.termItemList[index] = value
	end
	def addTermVariable(symbol,exponent,negative)
		termVar = TermVariable.new(symbol)
		termVar.setNegative(negative)
		termVar.setExponent(exponent)
		addTermItem(termVar)
	end
	def addTermFraction(num,den,exponent,negative)
		simpleFrac  = TermFraction.new(num,den)
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
	def consistsVariableOnly()
		return (!consistsCoefficient()) && (!consistsFraction())
	end
	def consistsCoefficient()
		self.termItemList.each do |termItem|
			return true if(termItem.class.name=="TermCoefficient")
		end
		return false
	end
	def consistsCoefficientOnly()
		return (!consistsVariable()) && (!consistsFraction())
	end
	def consistsFraction()
		self.termItemList.each do |termItem|
			return true if(termItem.class.name=="TermFraction")
		end
		return false
	end
	def consistsFractionOnly()
		return (!consistsVariable()) && (!consistsCoefficient())
	end
	def reduceTerm()
		self.termItemList.each do |termItem|
			self.termItemList.delete(termItem) if (termItem.class.name=="TermCoefficient" && termItem.base ==1)
		end
	end

	def sortTermItem()
		groupedTermItemList = self.termItemList.group_by {|x| x.class.name}
		self.termItemList =[]
		self.termItemList += groupedTermItemList["TermCoefficient"] if groupedTermItemList["TermCoefficient"]
		self.termItemList += groupedTermItemList["TermFraction"] if   groupedTermItemList["TermFraction"]
		self.termItemList += groupedTermItemList["TermVariable"] if   groupedTermItemList["TermVariable"]
	end
	def toLatexString
		self.sortTermItem()
		latexString =""
		self.termItemList.each do |termItem|
			if termItem.negativeFlag() || termItem.baseNegativeFlag() ||!consistsVariable
				latexString += "("+termItem.toLatexString()+")"
			else
				latexString += termItem.toLatexString()
			end
		end
		if exponentFlag()
			latexString="{("+latexString+")}"
			latexString="\\sqrt"+latexString if @exponent == 0.5
		end
		exponentString =""
		exponentString ="^{"+@exponent.to_s+"}" if exponentFlag()&& @exponent != 0.5
		negativeString = ""
		negativeString = "-" if negativeFlag()
		return negativeString+latexString+exponentString;
	end
	def setLatexString(latexString)
		#remove spaces from LatexString
		@latexString = latexString
		parseLatexString(latexString)
	end
	def parseLatexString(latexString)
		#break latexString into terms based on @add,@subtract,@eq,@lt,@gt
		
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
		@baseNegative = @negative
	end
	def simplifyCoefficient()
		#Calculating Final TermCoefficient
		groupedTermItemList = self.termItemList.group_by {|x| x.class.name}
		if groupedTermItemList["TermCoefficient"]
			self.termItemList =[]
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
		self.termItemList += groupedTermItemList["TermFraction"] if   groupedTermItemList["TermFraction"]
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
		puts "1:"+toLatexString()
		simplifyItemExponent()
		puts "2:"+toLatexString()
		simplifyItemNegative()
		puts "3:"+toLatexString()
		simplifyExponent()
		puts "4:"+toLatexString()
		simplifyNegative()
		puts "5:"+toLatexString()
		simplifyCoefficient()
		puts "6:"+toLatexString()
		simplifyVariable()
		puts "7:"+toLatexString()
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
		variableList = variableList.uniq{ |var| var.symbol}
		return variableList
	end
	def operateExpression(op,termItem)
		exp = Expression.new()
		exp.expressionItemList=[self,op,termItem]
		return exp
	end
	def *(other)
		selfRef = self.cloneForOperation()
		otherRef = TermCoefficient.new(other) if other.is_a?(Integer) || other.is_a?(Float)
		if other.class.name != "Expression" && other.class.name != "Term"
			common=false
			selfRef.expressionItemList.each do |expressionItem|
				if otherRef.class.name == selfRef.class.name
					common = true
					expressionItem = expressionItem*otherRef
					break
				end
			end
			selfRef.expressionItemList << otherRef if !common
			return selfRef
		else
			# Pending
		end
	end
	def /(other)
		selfRef = self.cloneForOperation()
		otherRef = TermCoefficient.new(other) if other.is_a?(Integer) || other.is_a?(Float)
		if other.class.name != "Expression" && other.class.name != "Term"
			common=false
			selfRef.expressionItemList.each do |expressionItem|
				if otherRef.class.name == selfRef.class.name
					common = true
					expressionItem = expressionItem/otherRef
					break
				end
			end
			selfRef.expressionItemList << TermFraction.new(1,otherRef) if !common
			return selfRef
		else
			# Pending
		end
	end
	def +@(other)
		selfRef = self.cloneForOperation()
		exp = Expression.new()
		otherRef = TermCoefficient.new(other) if other.is_a?(Integer) || other.is_a?(Float)
		if other.class.name != "Expression" && other.class.name != "Term"
			if selfRef.termItemList.size ==1 && otherRef.class.name == selfRef.class.name
				selfRef.termItemList[0] = selfRef.termItemList[0]+otherRef.termItemList[0]
				return selfRef 
			else
				exp.expressionItemList=[selfRef,otherRef]
				return exp
			end
			
		else
			# Pending
		end
	end
	def -@(other)
		selfRef = self.cloneForOperation()
		exp = Expression.new()
		otherRef = TermCoefficient.new(other) if other.is_a?(Integer) || other.is_a?(Float)
		if other.class.name != "Expression" && other.class.name != "Term"
			if selfRef.termItemList.size ==1 && otherRef.class.name == selfRef.class.name
				selfRef.termItemList[0] = selfRef.termItemList[0]-otherRef.termItemList[0]
				return selfRef 
			else
				exp.expressionItemList=[selfRef,otherRef.negateTermItem()]
				return exp
			end
			
		else
			# Pending
		end
	end
end