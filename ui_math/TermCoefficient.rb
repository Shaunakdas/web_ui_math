require_relative 'TermVariable'
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
		self.calcFinalValue() <=> another.calcFinalValue()
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
	def toLatexString
		#Display precaution
		exponentString =""
		exponentString ="^{"+@exponent.to_s+"}" if exponentFlag()
		negativeString = ""
		negativeString = "-" if negativeFlag()
		baseString = @base.to_s
		if baseNegativeFlag()
			baseString  = (baseNegativeFlag()? "-":"+")+baseString
			if negativeFlag() || exponentFlag()
				baseString="("+baseString+")"
			end
		end
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
		selfRef = selfRef = Marshal.load(Marshal.dump(self))
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
end