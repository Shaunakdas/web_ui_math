require_relative 'Term'
require_relative 'Expression'
class TermFraction
	include Comparable
	attr_accessor :baseNumerator,:baseDenominator, :exponent, :negative
	def initialize(baseNumerator,baseDenominator)
		if baseNumerator.is_a?(Integer) || baseNumerator.is_a?(Float)
			@baseNumerator = TermCoefficient.new(baseNumerator) 
			@baseNumerator.negative = @baseNumerator.baseNegative
		else
			@baseNumerator = baseNumerator
			@baseNumerator.negative = baseNumerator.negative||baseNumerator.baseNegative
		end
		@baseNumerator.baseNegative = false

		if baseDenominator.is_a?(Integer) || baseDenominator.is_a?(Float)
			@baseDenominator = TermCoefficient.new(baseDenominator)
			@baseDenominator.negative = @baseDenominator.baseNegative
		else 
			@baseDenominator = baseDenominator
			@baseDenominator.negative = baseDenominator.negative||baseDenominator.baseNegative
		end
		@baseDenominator.baseNegative = false
		@exponent=1
		@negative= false
	end
	def numerator()
		return @baseNumerator.cloneForOperation()
	end
	def denominator()
		return @baseDenominator.cloneForOperation()
	end
	def consistsCoefficient()
		return baseNumerator.consistsCoefficient() || baseDenominator.consistsCoefficient() 
	end
	def consistsVariable()
		return getVariableList().length>0 ? true:false
	end
	def <=>(otherTermFrac)

		selfRef = self.cloneForOperation()
		otherTermFracRef = otherTermFrac.cloneForOperation()
		finalDenominator = selfRef.lcmDenominator(otherTermFracRef)
		puts selfRef.toLatexString()
		puts otherTermFracRef.toLatexString()
		selfRef.baseNumerator = selfRef.baseNumerator.multiply(finalDenominator.divide(selfRef.baseDenominator))
		otherTermFracRef.baseNumerator = otherTermFracRef.baseNumerator.multiply(finalDenominator.divide(otherTermFracRef.baseDenominator))
		selfRef.baseNumerator <=> otherTermFracRef.baseNumerator
	end
	def cloneForOperation()
		selfRef = Marshal.load(Marshal.dump(self))
		selfRef.simplify()
		selfRef.baseNumerator.negative = true if selfRef.negative
		selfRef.negative = false
		return selfRef
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
	def baseNegativeFlag()
		return false
	end
	def toLatexString
		exponentString =""
		exponentString ="^{"+@exponent.to_s+"}" if exponentFlag()&& @exponent != 0.5
		negativeString = ""
		negativeString = "-" if negativeFlag()
		if @baseDenominator.class.name == "TermCoefficient"
			if @baseDenominator.base == 1
				baseString = @baseNumerator.toLatexString() 
			else
				baseString = "\\frac{"+@baseNumerator.toLatexString()+"}{"+@baseDenominator.toLatexString()+"}"
			end
		else
			baseString = "\\frac{"+@baseNumerator.toLatexString()+"}{"+@baseDenominator.toLatexString()+"}"
		end
		baseString="{("+baseString+")}" if exponentFlag()
		baseString="\\sqrt"+baseString if @exponent == 0.5
		return negativeString+baseString+exponentString
	end
	def to_s
		toLatexString()
	end
	def simplifyItemExponent()
		#Calculating individual item exponent values
		@baseNumerator.simplifyExponent()
		@baseDenominator.simplifyExponent()
	end
	def simplifyItemNegative()
		#Calculating individual item Negative Sign
		@baseNumerator.simplifyNegative()
		@baseDenominator.simplifyNegative()
	end
	def simplifyExponent()
		if exponentFlag()
			@baseNumerator.negative = ((@exponent%2!=0)? true:false)  if @baseNumerator.negative
			@baseDenominator.negative = ((@exponent%2!=0)? true:false)  if @baseDenominator.negative
			@baseNumerator.exponent = @baseNumerator.exponent*@exponent
			@baseDenominator.exponent = @baseDenominator.exponent*@exponent
			@baseNumerator.simplifyExponent()
			@baseDenominator.simplifyExponent()
			@exponent =1
		end
	end
	def simplifyNegative()
		@negative = (((@baseNumerator.negative^@baseNumerator.baseNegative)^(@baseDenominator.negative^@baseDenominator.baseNegative))^@negative)
		@baseNumerator.negative = false
		@baseDenominator.negative = false
		@baseNumerator.baseNegative= false
		@baseDenominator.baseNegative= false
	end
	def simplify()
		simplifyItemExponent()
		simplifyItemNegative()
		simplifyExponent()
		simplifyNegative()
	end
	def add(otherTermFrac)
		selfRef = self.cloneForOperation()
		otherTermFracRef = otherTermFrac.cloneForOperation()
		puts "otherTermFrac-add"+otherTermFrac.toLatexString()
		finalDenominator = selfRef.lcmDenominator(otherTermFracRef)
		selfRef.baseNumerator = selfRef.baseNumerator.multiply(finalDenominator.divide(selfRef.baseDenominator))
		otherTermFracRef.baseNumerator = otherTermFracRef.baseNumerator.multiply(finalDenominator.divide(otherTermFracRef.baseDenominator))
		
		finalNumerator = selfRef.baseNumerator.add(otherTermFracRef.baseNumerator)
		finalNumerator.simplify()
		newFrac = TermFraction.new(finalNumerator,finalDenominator)
		newFrac.simplify()
		return newFrac
	end
	def convertTermVariable(termVar,substituteNum,substituteDen)
		initialize(substituteNum,substituteDen)
		@exponent = termVar.exponent if termVar.exponentFlag()
		@negative = termVar.negative if termVar.negativeFlag()
	end
	def gcd(a, b)
	 	b == 0 ? a : gcd(b, a.modulo(b))
	end
	def lcmDenominator(otherFrac)
		lcmDen = TermCoefficient.new(@baseDenominator.base.lcm(otherFrac.baseDenominator.base))
		lcmDen.negative = (@baseDenominator.negative||otherFrac.baseDenominator.negative)
		return lcmDen
	end
	def reduce()
		baseGcd = gcd(@baseNumerator.base,@baseDenominator.base)
		@baseNumerator.base = @baseNumerator.base/baseGcd
		@baseDenominator.base = @baseDenominator.base/baseGcd
	end
	def reduceDenominator()
		if @baseDenominator.base ==1
			newTerm = @baseNumerator
			newTerm.setExponent(@exponent)
			newTerm.setNegative(@negative)
			return newTerm
		else
			return self
		end
	end
	def reduceFormWithDen()
		selfRef = Marshal.load(Marshal.dump(self))
		selfRef.simpleFraction()
		puts "reduceFormWithDen"+ selfRef.toLatexString()
		return selfRef
	end
	def reduceForm()
		selfRef = Marshal.load(Marshal.dump(self))
		selfRef.simpleFraction()
		if selfRef.baseDenominator.base ==1
			return selfRef.baseNumerator
		elsif selfRef.baseDenominator.base ==-1
			return selfRef.baseNumerator.negateTerm()
		else
			return selfRef
		end

	end
	def ratioForm()
		return baseNumerator.toLatexString()+":"+baseDenominator.toLatexString()
	end
	def simpleFraction()
		simplify()
		puts "self.simplify()"+self.toLatexString()
		reduce()
		puts "self.reduce()"+self.toLatexString()
	end
	def finalValue()
		simpleFraction()
		@baseDenominator.base =1 if @baseDenominator.base==0
		@baseNumerator = @baseNumerator.divide(@baseDenominator)
		return @baseNumerator.calcFinalValue()
	end
	def calcFinalValue()
		selfRef = Marshal.load(Marshal.dump(self))
		selfRef.simpleFraction()
		puts "selfRef.toLatexString()"+selfRef.toLatexString()
		selfRef.baseDenominator =TermCoefficient.new(1) if selfRef.baseDenominator.base==0
		selfRef.baseNumerator = selfRef.baseNumerator.divide(selfRef.baseDenominator)
		return selfRef.baseNumerator.calcFinalValue()
	end
	def negateTermItem()
		puts "Negative"+@negative.to_s
		negativeTermFrac = Marshal.load(Marshal.dump(self))
		negativeTermFrac.negative= true
		negativeTermFrac.negative = !@negative if @negative
		return negativeTermFrac
	end
	def reciprocal()
		reciprocal = Marshal.load(Marshal.dump(self))
		reciprocal.baseNumerator = reciprocal.baseDenominator
		reciprocal.baseDenominator = Marshal.load(Marshal.dump(self.baseNumerator))
		return reciprocal
	end
	def getVariableList()
		return []
	end
	def ratioFrom()
		exponentString =""
		exponentString ="^{"+@exponent.to_s+"}" if exponentFlag()
		negativeString = ""
		negativeString = "-" if negativeFlag()
		baseString = ""+@baseNumerator.toLatexString()+":"+@baseDenominator.toLatexString()
		baseString="{("+baseString+")}" if exponentFlag()
		return negativeString+baseString+exponentString
	end
	def percentage()
		return 100*self.calcFinalValue()
	end
	def operateExpression(op,termItem)
		exp = Expression.new()
		exp.expressionItemList=[self,op,termItem]
		return exp
	end
	def operate(op,termItem)
		puts "Symbol"+op.symbol
		puts termItem.class.name
		puts case op.symbol
		when "+"
			return self.+@termItem
		when "-"
			return self.-@termItem
		when "\\times"
			return self*@termItem
		when "\\div"
			return self/@termItem
		else

		end
	end
	def *(other)
		resultTerm = Term.new()
		selfRef = self.cloneForOperation()
		if other.is_a?(Integer) || other.is_a?(Float)
			selfRef.baseNumerator=selfRef.baseNumerator*other
			return selfRef
		else
			otherRef = other.cloneForOperation()
			if other.class.name == "TermCoefficient"
				selfRef.baseNumerator=selfRef.baseNumerator*other
				return selfRef
			elsif other.class.name == "TermVariable"
				resultTerm.termItemList=[selfRef,otherRef]
				return resultTerm
			elsif other.class.name == "TermFraction"
				selfRef.baseNumerator=selfRef.baseNumerator*otherRef.baseNumerator
				selfRef.baseDenominator=selfRef.baseDenominator*otherRef.baseDenominator
				selfRef.negative= selfRef.negative^otherRef.negative
				return selfRef
			else
				return otherRef*selfRef
			end
		end
	end
	def /(other)
		selfRef = self.cloneForOperation()
		if other.is_a?(Integer) || other.is_a?(Float)
			selfRef.baseDenominator=selfRef.baseDenominator*other
			return selfRef
		else
			otherRef = other.cloneForOperation()
			if other.class.name == "TermCoefficient"
				selfRef.baseDenominator=selfRef.baseDenominator*other
				return selfRef
			elsif other.class.name == "TermVariable"
				selfRef.baseDenominator=selfRef.baseDenominator*other
				return selfRef
			elsif other.class.name == "TermFraction"
				return otherRef.reciprocal*selfRef
			else
				return otherRef/selfRef
			end
		end
	end
	def +@(other)
		selfRef = self.cloneForOperation()
		if other.is_a?(Integer) || other.is_a?(Float)
			return selfRef.add(TermFraction.new(other,1))
		else
			otherRef = other.cloneForOperation()
			if other.class.name == "TermCoefficient"
				return selfRef.add(TermFraction.new(otherRef,1))
			elsif other.class.name == "TermVariable"
				return selfRef.operateExpression(Operator.new("+"),otherRef)
			elsif other.class.name == "TermFraction"
				puts "+otherRef.class.name"+otherRef.toLatexString()
				return selfRef.add(otherRef)
			else
				return otherRef.+@selfRef
			end
		end
	end
	def -@(other)
		if other.is_a?(Integer) || other.is_a?(Float)
			return selfRef.add(TermFraction.new(-other,1))
		else
			otherRef = other.cloneForOperation()
			selfRef = self.cloneForOperation()
			if other.class.name == "TermCoefficient"
				return selfRef.add(TermFraction.new(otherRef.negateTermItem(),1))
			elsif other.class.name == "TermVariable"
				return selfRef.operateExpression(Operator.new("-"),otherRef)
			elsif other.class.name == "TermFraction"
				puts "otherRef.class.name"+otherRef.class.name
				otherRef= otherRef.negateTermItem()
				puts "otherRef.class.name"+otherRef.toLatexString()
				return selfRef.+@otherRef
			else
				return selfRef.+@otherRef
			end
		end
	end
end