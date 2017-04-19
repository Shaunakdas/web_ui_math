require_relative 'Term'
class TermFraction
	include Comparable
	attr_accessor :baseNumerator,:baseDenominator, :exponent, :negative
	def initialize(baseNumerator,baseDenominator)
		if baseNumerator.is_a?Integer
			@baseNumerator = TermCoefficient.new(baseNumerator) 
			@baseNumerator.negative = @baseNumerator.baseNegative
		else
			@baseNumerator = baseNumerator
			@baseNumerator.negative = baseNumerator.negative||baseNumerator.baseNegative
		end
		@baseNumerator.baseNegative = false

		if baseDenominator.is_a?Integer
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
	def <=>(otherTermFrac)
		selfRef = Marshal.load(Marshal.dump(self))
		selfRef.simplify()
		otherTermFracRef = Marshal.load(Marshal.dump(otherTermFrac))
		otherTermFracRef.simplify()
		selfRef.baseNumerator.negative = !selfRef.baseNumerator.negative if selfRef.negative
		otherTermFracRef.baseNumerator.negative = !otherTermFracRef.baseNumerator.negative if otherTermFracRef.negative
		finalDenominator = selfRef.lcmDenominator(otherTermFracRef)
		selfRef.baseNumerator = selfRef.baseNumerator.multiply(finalDenominator.divide(selfRef.baseDenominator))
		otherTermFracRef.baseNumerator = otherTermFracRef.baseNumerator.multiply(finalDenominator.divide(otherTermFracRef.baseDenominator))
		puts "selfRef.baseNumerator"+selfRef.baseNumerator.to_s
		puts "otherTermFracRef.baseNumerator"+otherTermFracRef.baseNumerator.to_s
		selfRef.baseNumerator <=> otherTermFracRef.baseNumerator
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
		exponentString ="^{"+@exponent.to_s+"}" if exponentFlag()
		negativeString = ""
		negativeString = "-" if negativeFlag()
		baseString = "\\frac{"+@baseNumerator.toLatexString()+"}{"+@baseDenominator.toLatexString()+"}"
		baseString="{("+baseString+")}" if exponentFlag()
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
		selfRef = Marshal.load(Marshal.dump(self))
		selfRef.simplify()
		otherTermFracRef = Marshal.load(Marshal.dump(otherTermFrac))
		otherTermFracRef.simplify()
		#Bringing negative inside
		selfRef.baseNumerator.negative = !selfRef.baseNumerator.negative if selfRef.negative
		otherTermFracRef.baseNumerator.negative = !otherTermFracRef.baseNumerator.negative if otherTermFracRef.negative
		
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
	def getVariableList()
		return []
	end
end