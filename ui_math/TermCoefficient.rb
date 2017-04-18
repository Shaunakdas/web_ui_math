require_relative 'TermVariable'
class TermCoefficient
	include Comparable
	attr_accessor :base,:baseNegative, :exponent, :negative,:final
	def initialize(base)
		if base<0
			@baseNegative  = (base<0)? true:false
		end
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
	def add(otherTermCoeff)
		selfRef = Marshal.load(Marshal.dump(self))
		selfRef.simplify()
		otherTermCoeffRef = Marshal.load(Marshal.dump(otherTermCoeff))
		otherTermCoeffRef.simplify()
		selfRef.base = -selfRef.base if selfRef.negative
		otherTermCoeffRef.base = -otherTermCoeffRef.base if otherTermCoeffRef.negative
		selfRef.base += otherTermCoeffRef.base
		selfRef.negative = (selfRef.base<0)? true:false
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
		baseNegative =@baseNegative
		base =@base
		negative =@negative
		if baseNegativeFlag()
			baseNegative = (@exponent%2!=0)? true:false
		end
		if exponentFlag()
			base = @base**@exponent
			exponent =1
		end
		negative = baseNegative^@negative
		return -base if negative
		return base
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