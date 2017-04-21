require_relative '../ui_math/TermFraction'
class RatioProportion
	attr_accessor :latexStringList
	def initialize()
		latexStringList=[]
		commonOpInit()
	end
	def commonOpInit()
		@bracStart = Operator.new("(")
		@bracEnd = Operator.new(")")
		@curlyStart = Operator.new("{")
		@curlyEnd = Operator.new("}")
		@eq = Operator.new("=")
		@times = Operator.new("\\times")
		@div = Operator.new("\\div")
		@add = Operator.new("+")
		@subtract = Operator.new("-")
		@lt = Operator.new("<")
		@gt = Operator.new(">")
		@and = Operator.new("&")
		@sqrt = Operator.new("\\sqrt")
		@cbrt = Operator.new("\\cbrt")
		@percent = Operator.new("\\%")
	end
	def simpleRatio(a,b,unit)
		latexStringList << "Required ratio is "+a.to_s+" unit : "+b.to_s+" unit"
		frac1 = TermFraction.new(a,b)
		latexStringList << "= "+frac1.toLatexString()
		rationalNumber = new RationalNumber()
		rationalNumber.simplestFromSmall(a,b)

		@latexStringList = rationalNumber.latexStringList()
		termItemgcd = TermCoefficient.new(gcd(a.abs,b.abs))
		frac2 = Fraction.new(frac1.baseNumerator.divide(termItemgcd),frac1.baseDenominator.divide(termItemgcd))
		@latexStringList << "Required Ratio is "+ frac2.baseNumerator.toLatexString()+" : "+frac2.baseDenominator.toLatexString()
	end
	def equivalentRatio(a,b,c,numeratorFlag)
		latexStringList << "Required ratio is "+a.to_s+" : "+b.to_s
		frac1 = TermFraction.new(a,b)
		latexStringList << "= "+frac1.toLatexString()
		rationalNumber = new RationalNumber()
		rationalNumber.equivalentRationalNumber(a,b,c,numeratorFlag)
		mult = c/a
		mult = c/b if numeratorFlag
		@latexStringList = rationalNumber.latexStringList()
		@latexStringList << "Required Ratio is "+ TermFraction.new(a*mult).toLatexString()+" : "+TermFraction.new(a*mult).toLatexString()
	end
	def gcd(a, b)
	 	b == 0 ? a : gcd(b, a.modulo(b))
	end
	def checkProportion(a,b,c,d)
		frac1 = TermFraction.new(a,b)
		frac2 = TermFraction.new(c,d)
		rationalNumber = new RationalNumber()
		rationalNumber.simplestFromSmall(a,b)
		latexStringList << "Ratio of "+a.to_s+" to "+b.to_s
 		latexStringList << rationalNumber.latexStringList
		rationalNumber.latexStringList = []
		latexStringList << "Ratio of "+c.to_s+" to "+d.to_s
 		latexStringList << rationalNumber.latexStringList
 		if frac1 == frac2
 			latexStringList << "Since both the ratios are same"
 			latexStringList << "Hence"+frac1.ratioForm()+" = "+frac2.ratioForm()
 			latexStringList << "Therefore "+a.to_s+", "+b.to_s+", "+c.to_s+" and "+d.to_s+" are in proportion"
 		else
 			latexStringList << "Since both the ratios are different"
 			latexStringList << "Therefore "+a.to_s+", "+b.to_s+", "+c.to_s+" and "+d.to_s+" are not in proportion"
 		
 		end
	end
	def unitaryMethod(x,y,z,firstText,secondText)
		frac = TermFraction.new(y,x)
		finalFrac = TermFraction.new(y*z,x)
		exp = Expression.new()
		exp.expressionItemList = [TermCoefficient.new(frac.calcFinalValue()),@times,TermCoefficient.new(z),@eq,TermCoefficient.new(finalFrac.calcFinalValue())]
		
		latexStringList << firstText+x.to_s+secondText+y.to_s
		latexStringList << firstText+1.to_s+secondText+frac.calcFinalValue()
		latexStringList << firstText+1.to_s+secondText+exp.toLatexString()
		latexStringList << firstText+1.to_s+secondText+finalFrac.calcFinalValue()
	end
	def checkEquivalence(a,b,c,d)
		frac1 = TermFraction.new(a,b)
		frac2 = TermFraction.new(c,d)
		rationalNumber = new RationalNumber()
		rationalNumber.simplestFromSmall(a,b)
		latexStringList << "Ratio of "+a.to_s+" to "+b.to_s
 		latexStringList << rationalNumber.latexStringList
		rationalNumber.latexStringList = []
		latexStringList << "Ratio of "+c.to_s+" to "+d.to_s
 		latexStringList << rationalNumber.latexStringList
 		if frac1 == frac2
 			latexStringList << "Since both the ratios are same"
 			latexStringList << "Hence"+frac1.ratioForm()+" = "+frac2.ratioForm()
 			latexStringList << "Therefore "+frac1.ratioForm()+" and "+frac2.ratioForm()+" are in equivalence"
 		else
 			latexStringList << "Since both the ratios are different"
 			latexStringList << "Therefore "+frac1.ratioForm()+" and "+frac2.ratioForm()+" are not in equivalence"
 		
 		end
	end
	def fractionToPercentage(a,b)
		frac1 = TermFraction.new(a,b)
		percent = frac1.percentage
		exp = Expression.new()
		exp.expressionItemList = [frac1,TermFraction.new(100,100),@eq,TermFraction.new(percent,100)]
		latexStringList << exp.toLatexString()+percent.to_s+"(out of hundred)"
		latexStringList << percent.to_s+@percent.toLatexString()
	end
	def decimalToPercentage(a)
		item = TermCoefficient.new(a)
		percent = 100*a
		exp = Expression.new()
		exp.expressionItemList = [item,@eq,item,@times,TermCoefficient.new(100),@percent]
		latexStringList << exp.toLatexString()
		exp[2]= TermFraction.new(percent,100)
		latexStringList << exp.toLatexString()
		exp.expressionItemList = [item,@eq,percent,@percent]
		latexStringList << exp.toLatexString()
	end

	def ratioToPercentage(a,b)
		firstPart = TermCoefficient.new(100*a.to_f)/(a+b)
		secondPart = TermCoefficient.new(100*b.to_f)/(a+b)
		denExp = Expression.new()
		denExp.expressionItemList = [TermCoefficient.new(a),@add,TermCoefficient.new(b)]
		latexStringList << " Total part is "+(a+b).to_s
		exp= Expression.new()
		exp.expressionItemList = [TermFraction.new(a,denExp),@times,TermCoefficient.new(100),@percent,@eq,firstPart]
		latexStringList << " First percentage is "+exp.toLatexString()
		exp[0] = TermFraction.new(b,denExp)
		exp.last = TermCoefficient.new(secondPart
		latexStringList << " First percentage is "+exp.toLatexString()
	end
	def calcProfitPercent(profit,cost)
		exp = Expression.new()
		exp.expressionItemList = [TermFraction.new(profit,cost),@times,TermCoefficient.new(100)]
		latexStringList << " Profit percent is = \\frac{Profit}{Cost} \\times 100 "+exp.toLatexString()
	end
	def calcProfit(profitPercent,cost)
		profit = (profitPercent.to_f*cost)/100
		exp = Expression.new()
		exp.expressionItemList = [TermFraction.new(profitPercent,100),@times,TermCoefficient.new(cost),@eq,TermCoefficient.new(profit)]
		latexStringList << " Profit = Profit \\% \\times Cost Price "
		latexStringList << exp.toLatexString()
		latexStringList << " Selling Price = Cost Price + Profit "
		latexStringList << " Selling Price = "+cost.to_s+" + "+profit.to_s
		latexStringList << " Selling Price = "+(cost+profit).to_s
	end
	def calcLossPercent(loss,cost)
		exp = Expression.new()
		exp.expressionItemList = [TermFraction.new(loss,cost),@times,TermCoefficient.new(100)]
		latexStringList << " Loss percent is = \\frac{Loss}{Cost} \\times 100 "+exp.toLatexString()
	end
	def calcLoss(lossPercent,cost)
		loss = (lossPercent.to_f*cost)/100
		exp = Expression.new()
		exp.expressionItemList = [TermFraction.new(lossPercent,100),@times,TermCoefficient.new(cost),@eq,TermCoefficient.new(loss)]
		latexStringList << " Loss = Loss \\% \\times Cost Price "
		latexStringList << exp.toLatexString()
		latexStringList << " Selling Price = Cost Price - Loss "
		latexStringList << " Selling Price = "+cost.to_s+" - "+loss.to_s
		latexStringList << " Selling Price = "+(cost-loss).to_s
	end
	def calcSimpleInterest(sum,rate,yearCount)
		latexStringList << " The sum borrowed = "+sum.to_s
		latexStringList << " Rate of interest = "+rate.to_s+"\\% per year"
		interest = (sum.to_f*rate)/100
		exp = Expression()
		exp.expressionItemList = [@eq,TermFraction(15,100),@times,TermCoefficient.new(sum),@eq,TermCoefficient.new(interest)]
		latexStringList << " The interest to paid after 1 year = "+exp.toLatexString()
		if yearCount>1
			interest = interest*yearCount
			exp.expressionItemList = [interest,@times,TermCoefficient.new(yearCount),@eq,interest]
			latexStringList << " The interest to paid after "+yearCount.to_s+" years = "+exp.toLatexString()
		end
		exp.expressionItemList = [TermCoefficient.new(sum),@add,TermCoefficient.new(interest),TermCoefficient.new(sum+interest)]

		latexStringList << " The total amount to be paid after T years = A = P + I"
		latexStringList << " Hence the total amount to be paid after "+yearCount.to_s+" years = "+exp.toLatexString()
	end
	def calcIncreaseFromPercent(increasePercent,price)
		increase = (increasePercent.to_f*price)/100
		exp = Expression.new()
		exp.expressionItemList = [TermFraction.new(increasePercent,100),@times,TermCoefficient.new(price),@eq,TermCoefficient.new(increase)]
		latexStringList << increasePercent+"\\% of "+ price.to_s + " =  "+ exp.toLatexString()
		latexStringList << "New Price = Old Price + Increase"
		latexStringList << "New Price = "+price.to_s+" + "+increase.to_s+" = "+(price+increase).to_s 
	end
	def calcDecreaseFromPercent(decreasePercent,price)
		decrease = (decreasePercent.to_f*price)/100
		exp = Expression.new()
		exp.expressionItemList = [TermFraction.new(decreasePercent,100),@times,TermCoefficient.new(price),@eq,TermCoefficient.new(decrease)]
		latexStringList << decreasePercent+"\\% of "+ price.to_s + " =  "+ exp.toLatexString()
		latexStringList << "New Price = Old Price - Decrease"
		latexStringList << "New Price = "+price.to_s+" - "+decrease.to_s+" = "+(price-decrease).to_s 
	end
	def calcDiscountPercent(markedPrice,salesPrice)
		discount = markedPrice - salesPrice
		dscountPercent = (discount.to_f*100)/markedPrice
		latexStringList << "Discount =  Marked Price - Sales Price"
		latexStringList << "New Price = "+markedPrice.to_s+" - "+salesPrice.to_s+" = "+(markedPrice-salesPrice).to_s 
		exp = Expression.new()
		exp.expressionItemList = [TermFraction.new(discount,markedPrice),@times,TermCoefficient.new(100),@eq,TermCoefficient.new(discount),@percent]
		latexStringList << "Discount Percentage =  \\frac{Discount}{Marked Price}"
		latexStringList << "Discount Percentage =  "+exp.toLatexString()
	end
end