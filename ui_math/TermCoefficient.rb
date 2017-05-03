require_relative 'TermVariable'
require_relative 'Expression'
class TermCoefficient
	include Comparable
	attr_accessor :base,:baseNegative, :exponent, :negative,:final
	def initialize(base)
		@baseNegative  = (base<0)? true:false
		@base = base.abs
		@exponent=1
		@negative=false
	end
	def <=>(another)
		puts "TermCoefficient Compare"
		self.calcFinalValue() <=> another.calcFinalValue()
	end
	def cloneForOperation()
		selfRef = Marshal.load(Marshal.dump(self))
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
		return !(defined?(@baseNegative)).nil? && @baseNegative ==true
	end
	def consistsCoefficient()
		return true
	end
	def consistsVariable()
		return false
	end
	def toLatexString
		#Display precaution
		exponentString =""
		exponentString ="^{"+@exponent.to_s+"}" if exponentFlag() && @exponent != 0.5
		negativeString = ""
		negativeString = "-" if negativeFlag()
		baseString = @base.to_s 
		if baseNegativeFlag()
			baseString  = (baseNegativeFlag()? "-":"+")+baseString
			if negativeFlag() || exponentFlag()
				baseString="("+baseString+")"
			end
		end
		baseString="\\sqrt{"+baseString+"}" if @exponent == 0.5
		return negativeString+baseString+exponentString
	end
	def to_s
		toLatexString()
	end
	def simplifyExponent()
		if baseNegativeFlag()
			@baseNegative = (@exponent%2!=0)? true:false
		end
		if exponentFlag()
			@base = @base**@exponent
			@exponent =1
		end
	end

	def simplifyNegative()
		@negative = @baseNegative^@negative
		@baseNegative=false
	end
	def simplify()
		simplifyExponent()
		simplifyNegative()
	end
	def cloneForOperation()
		selfRef = Marshal.load(Marshal.dump(self))
		selfRef.simplify()
		selfRef.base = -selfRef.base if selfRef.negative
		return selfRef
	end
	def add(otherTermCoeff)
		selfRef = self.cloneForOperation()
		otherTermCoeffRef = otherTermCoeff.cloneForOperation()
		selfRef.base += otherTermCoeffRef.base
		#Display precaution
		selfRef.negative = (selfRef.base<0)? true:false
		selfRef.base = selfRef.base.abs
		return selfRef
	end
	def multiply(otherTermCoeff)
		selfRef = self.cloneForOperation()
		otherTermCoeffRef = otherTermCoeff.cloneForOperation()
		selfRef.base = selfRef.base.to_f*otherTermCoeffRef.base
		selfRef.base = selfRef.base.to_i if selfRef.base%1==0
		#Display precaution
		selfRef.negative = (selfRef.base<0)? true:false
		selfRef.base = selfRef.base.abs
		return selfRef
	end
	def divide(otherTermCoeff)
		selfRef = self.cloneForOperation()
		otherTermCoeffRef = otherTermCoeff.cloneForOperation()

		selfRef.base = selfRef.base.to_f/otherTermCoeffRef.base
		selfRef.base = selfRef.base.to_i if selfRef.base%1==0
		#Display precaution
		selfRef.negative = (selfRef.base<0)? true:false
		puts "TermCoefficient.abs="+selfRef.base.to_s+"and"+selfRef.base.abs.to_s
		selfRef.base = selfRef.base.abs
		return selfRef
	end
	def convertTermVariable(termVar,substituteValue)
		initialize(substituteValue)
		@exponent = termVar.exponent if termVar.exponentFlag()
		@negative = termVar.negative if termVar.negativeFlag()

	end
	def finalValue()
		simplifyExponent()
		simplifyNegative()
		final = @negative? -@base:@base
		return final
	end
	def calcFinalValue()
		selfRef = Marshal.load(Marshal.dump(self))
		selfRef.simplify()
		return -selfRef.base if selfRef.negative
		return selfRef.base
	end
	def negateTermItem()
		puts "Negative"+@negative.to_s
		negativeTermCoeff = Marshal.load(Marshal.dump(self))
		negativeTermCoeff.negative= true
		negativeTermCoeff.negative = !@negative if @negative
		
		return negativeTermCoeff
	end
	def getVariableList()
		return []
	end
	def operateExpression(op,termItem)
		exp = Expression.new()
		exp.expressionItemList=[self,op,termItem]
		return exp
	end
	def operate(op,termItem)
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
		if other.is_a?(Integer) || other.is_a?(Float)
			return multiply(TermCoefficient.new(other))
		else
			otherRef = other.cloneForOperation()
			selfRef = self.cloneForOperation()
			if other.class.name == "TermCoefficient"
				return multiply(other)
			elsif other.class.name == "TermVariable"
				term = new Term()
				term.termItemList = [selfRef,other]
				return term
			else
				return otherRef*selfRef
			end
		end
	end
	def /(other)
		if other.is_a?(Integer) || other.is_a?(Float)
			return multiply(TermCoefficient.new(other))
		else
			otherRef = other.cloneForOperation()
			selfRef = self.cloneForOperation()
			if other.class.name == "TermCoefficient"
				return divide(other)
			elsif other.class.name == "TermVariable"
				denExp = Expression.new()
				denExp.expressionItemList = [other]
				return TermFraction.new(selfRef,denExp)
			elsif other.class.name == "TermFraction"
				return (otherRef).reciprocal*selfRef
			else
				return TermFraction.new(selfRef,other)
			end
		end
	end
	def +@(other)
		if other.is_a?(Integer) || other.is_a?(Float)
			return multiply(TermCoefficient.new(other))
		else
			otherRef = other.cloneForOperation()
			selfRef = self.cloneForOperation()
			if other.class.name == "TermCoefficient"
				return add(other)
			elsif other.class.name == "TermVariable"
				return selfRef.operateExpression(Operator.new("+"),otherRef)
			else
				return otherRef.+@selfRef
			end
		end
	end
	def -@(other)
		if other.is_a?(Integer) || other.is_a?(Float)
			return multiply(TermCoefficient.new(other))
		else
			otherRef = other.cloneForOperation()
			selfRef = self.cloneForOperation()
			if other.class.name == "TermCoefficient"
				return add(other.negateTermItem())
			elsif other.class.name == "TermVariable"
				return selfRef.operateExpression(Operator.new("-"),otherRef)
			else
				return otherRef.-@selfRef
			end
		end
	end
	def %(other)

	end
end