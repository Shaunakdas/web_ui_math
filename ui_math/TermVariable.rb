require_relative 'Variable'
class TermVariable
	include Comparable
	attr_accessor :variable, :exponent,:value,:negative
	def initialize(variableString)
		@variable = Variable.new(variableString)
		@exponent =1
		@negative=false
	end
	def <=>(another)
	    @variable.symbol <=> another.variable.symbol
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
	def consistsCoefficient()
		return false
	end
	def consistsVariable()
		return true
	end
	def toLatexString
		exponentString =""
		exponentString ="^{"+@exponent.to_s+"}" if exponentFlag() && @exponent != 0.5
		negativeString = ""
		negativeString = "-" if negativeFlag()
		baseString=@variable.toLatexString()
		baseString="\\sqrt{"+baseString +"}" if @exponent == 0.5
		return negativeString+baseString+exponentString
	end
	def negateTermItem()
		negativeTermVar = Marshal.load(Marshal.dump(self))
		negativeTermVar.negative= true
		negativeTermVar.negative = !@negative if @negative
		return negativeTermVar
	end
	def to_s
		toLatexString()
	end
	def simplifyExponent()
		
	end
	def simplifyNegative()
		
	end
	def calcValue(value)
		@value = value
		@value = value**@exponent if @exponent
	end
	def ==(other)
		if (defined?(@exponent)).nil?
			return @variable == (other.variable)
		else
			return (@variable == (other) && (@exponent==other.exponent))
		end
	end
	def getVariableList()
		return [@variable]
	end
	def operateExpression(op,termItem)
		exp = Expression.new()
		exp.expressionItemList=[self,op,termItem]
		return exp
	end
	def *(other)
		resultTerm = Term.new()
		if other.is_a?(Integer) || other.is_a?(Float)
			resultTerm.termItemList=[TermCoefficient.new(other),var]
			return resultTerm
		else
			otherRef = other.cloneForOperation()
			selfRef = self.cloneForOperation()
			if other.class.name == "TermCoefficient"
				resultTerm.termItemList=[other,var]
				return resultTerm
			elsif other.class.name == "TermVariable"
				if selfRef == otherRef && selfRef.exponent == otherRef.exponent && selfRef.negative == otherRef.negative
					resultTerm.termItemList=[TermCoefficient.new(2),var]
					return resultTerm
				elsif selfRef == otherRef && selfRef.exponent == otherRef.exponent && selfRef.negative != otherRef.negative
					return TermCoefficient.new(0)
				else

				end
				
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
				if selfRef == otherRef && selfRef.exponent == otherRef.exponent && selfRef.negative == otherRef.negative
					return TermCoefficient.new(1)
				elsif selfRef == otherRef && selfRef.exponent == otherRef.exponent && selfRef.negative != otherRef.negative
					return TermCoefficient.new(-1)
				elsif selfRef == otherRef && selfRef.exponent > otherRef.exponent
					selfRef.exponent = selfRef.exponent-otherRef.exponent
					selfRef.negative = selfRef.negative^otherRef.negative
					return selfRef
				elsif selfRef == otherRef && selfRef.exponent < otherRef.exponent
					otherRef.exponent = selfRef.exponent-otherRef.exponent
					otherRef.negative = selfRef.exponent^otherRef.exponent
					denExp = Expression.new()
					denExp.expressionItemList=[otherRef]
					return TermFraction.new(1,denExp)
				elsif selfRef == otherRef && selfRef.exponent == otherRef.exponent && selfRef.negative != otherRef.negative
					return TermCoefficient.new(-1)
				else
					return selfRef.operateExpression(Operator.new("+"),otherRef)
				end
			elsif other.class.name == "TermFraction"
				return reciprocal(otherRef)*selfRef
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
				return selfRef.operateExpression(Operator.new("+"),otherRef)
			elsif other.class.name == "TermVariable"
				if selfRef == otherRef && selfRef.exponent == otherRef.exponent && selfRef.negative == otherRef.negative
					resultTerm.termItemList=[TermCoefficient.new(2),var]
					return resultTerm
				elsif selfRef == otherRef && selfRef.exponent == otherRef.exponent && selfRef.negative != otherRef.negative
					return TermCoefficient.new(0)
				else
					return selfRef.operateExpression(Operator.new("+"),otherRef)
				end
			else
				return otherRef+selfRef
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
				return selfRef.operateExpression(Operator.new("+"),otherRef)
			elsif other.class.name == "TermVariable"
				if selfRef == otherRef && selfRef.exponent == otherRef.exponent && selfRef.negative != otherRef.negative
					resultTerm.termItemList=[TermCoefficient.new(2),var]
					return resultTerm
				elsif selfRef == otherRef && selfRef.exponent == otherRef.exponent && selfRef.negative == otherRef.negative
					return TermCoefficient.new(0)
				else
					return selfRef.operateExpression(Operator.new("-"),otherRef)
				end
			else
				return otherRef-selfRef
			end
		end
	end
end