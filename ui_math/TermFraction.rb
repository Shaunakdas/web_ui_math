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
		selfRef.baseNumerator = selfRef.baseNumerator.multiply(finalDenominator.divide(selfRef.baseDenominator))
		otherTermFracRef.baseNumerator = otherTermFracRef.baseNumerator.multiply(finalDenominator.divide(otherTermFracRef.baseDenominator))
		selfRef.baseNumerator <=> otherTermFracRef.baseNumerator
	end
	def cloneForOperation()
		selfRef = Marshal.load(Marshal.dump(self))
		selfRef.simplify()
		selfRef.baseNumerator.negative = !selfRef.baseNumerator.negative if selfRef.negative
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
	def toLatexString
		exponentString =""
		exponentString ="^{"+@exponent.to_s+"}" if exponentFlag()&& @exponent != 0.5
		negativeString = ""
		negativeString = "-" if negativeFlag()
		baseString = "\\frac{"+@baseNumerator.toLatexString()+"}{"+@baseDenominator.toLatexString()+"}"
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
			newTerm = TermCoefficient.new(@baseNumerator)
			newTerm.setExponent(@exponent)
			newTerm.setNegative(@negative)
			return newTerm
		else
			return self
		end
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
end