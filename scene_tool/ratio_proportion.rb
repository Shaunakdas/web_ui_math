require_relative '../ui_math/TermFraction'
require_relative '../ui_math/Expression'
require_relative 'rational_number'
class RatioProportion
	attr_accessor :latexStringList
	def initialize()
		@latexStringList=[]
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
		@ratio = Operator.new(":")
	end
	def simpleRatio(*args)
		a=args[0];b=args[1];unit=args[2]
		@latexStringList << "Required ratio is "+a.to_s+" unit : "+b.to_s+" unit"
		frac1 = TermFraction.new(a,b)
		@latexStringList << "= "+frac1.toLatexString()
		rationalNumber = RationalNumber.new()
		rationalNumber.simplestFormSmall(a,b)

		@latexStringList += rationalNumber.latexStringList()
		termItemgcd = TermCoefficient.new(gcd(a.abs,b.abs))
		frac2 = TermFraction.new(frac1.baseNumerator.divide(termItemgcd),frac1.baseDenominator.divide(termItemgcd))
		@latexStringList << "Required Ratio is "+ frac2.baseNumerator.toLatexString()+" : "+frac2.baseDenominator.toLatexString()
	end
	def equivalentRatio(*args)
		a=args[0];b=args[1];c=args[2];numeratorFlag=args[3]
		@latexStringList << "Required ratio is "+a.to_s+" : "+b.to_s
		frac1 = TermFraction.new(a,b)
		@latexStringList << "= "+frac1.toLatexString()
		rationalNumber = RationalNumber.new()
		rationalNumber.equivalentRationalNumber(a,b,c,numeratorFlag)
		mult = c/a
		mult = c/b if numeratorFlag
		@latexStringList += rationalNumber.latexStringList()
		exp = Expression.new()
		exp.expressionItemList = [TermCoefficient.new(a*mult),@ratio,TermCoefficient.new(b*mult)]; @latexStringList << "Required Ratio is "+ exp.toLatexString()
		# @latexStringList << "Required Ratio is "+ TermFraction.new(a*mult).toLatexString()+" : "+TermFraction.new(a*mult).toLatexString()
	end
	def gcd(a, b)
	 	b == 0 ? a : gcd(b, a.modulo(b))
	end
	def checkProportion(*args)
		a=args[0];b=args[1];c=args[2];d=args[3]
		frac1 = TermFraction.new(a,b)
		frac2 = TermFraction.new(c,d)
		rationalNumber = RationalNumber.new()
		rationalNumber.simplestFormSmall(a,b)
		@latexStringList << "Ratio of "+a.to_s+" to "+b.to_s
 		@latexStringList += rationalNumber.latexStringList
		rationalNumber.latexStringList = []
		rationalNumber.simplestFormSmall(c,d)
		@latexStringList << "Ratio of "+c.to_s+" to "+d.to_s
 		@latexStringList += rationalNumber.latexStringList
 		if frac1 == frac2
 			@latexStringList << "Since both the ratios are same"
 			@latexStringList << "Hence"+frac1.ratioForm()+" = "+frac2.ratioForm()
 			@latexStringList << "Therefore "+a.to_s+", "+b.to_s+", "+c.to_s+" and "+d.to_s+" are in proportion"
 		else
 			@latexStringList << "Since both the ratios are different"
 			@latexStringList << "Therefore "+a.to_s+", "+b.to_s+", "+c.to_s+" and "+d.to_s+" are not in proportion"
 		
 		end
	end
	def unitaryMethod(*args)
		x=args[0];y=args[1];z=args[2];firstText=args[3];secondText=args[4]
		frac = TermFraction.new(y,x)
		finalFrac = TermFraction.new(y*z,x)
		exp = Expression.new()
		exp.expressionItemList = [TermCoefficient.new(frac.calcFinalValue()),@times,TermCoefficient.new(z),@eq,TermCoefficient.new(finalFrac.calcFinalValue())]
		
		@latexStringList << firstText+x.to_s+secondText+y.to_s
		@latexStringList << firstText+1.to_s+secondText+frac.calcFinalValue().to_s
		@latexStringList << firstText+1.to_s+secondText+exp.toLatexString()
		@latexStringList << firstText+1.to_s+secondText+finalFrac.calcFinalValue().to_s
	end
	def checkEquivalence(*args)
		a=args[0];b=args[1];c=args[2];d=args[3]
		frac1 = TermFraction.new(a,b)
		frac2 = TermFraction.new(c,d)
		rationalNumber = RationalNumber.new()
		rationalNumber.simplestFormSmall(a,b)
		@latexStringList << "Ratio of "+a.to_s+" to "+b.to_s
 		@latexStringList += rationalNumber.latexStringList
		rationalNumber.latexStringList = []
		rationalNumber.simplestFormSmall(c,d)
		@latexStringList << "Ratio of "+c.to_s+" to "+d.to_s
 		@latexStringList += rationalNumber.latexStringList
 		if frac1 == frac2
 			@latexStringList << "Since both the ratios are same"
 			@latexStringList << "Hence"+frac1.ratioForm()+" = "+frac2.ratioForm()
 			@latexStringList << "Therefore "+frac1.ratioForm()+" and "+frac2.ratioForm()+" are in equivalence"
 		else
 			@latexStringList << "Since both the ratios are different"
 			@latexStringList << "Therefore "+frac1.ratioForm()+" and "+frac2.ratioForm()+" are not in equivalence"
 		
 		end
	end
	def fractionToPercentage(*args)
		a=args[0];b=args[1]
		frac1 = TermFraction.new(a,b)
		percent = frac1.percentage
		exp = Expression.new()
		exp.expressionItemList = [frac1,TermFraction.new(100,100),@eq,TermFraction.new(percent,100)]
		@latexStringList << exp.toLatexString()+"= "+percent.to_s+"(out of hundred)"
		@latexStringList << percent.to_s+@percent.toLatexString()
	end
	def decimalToPercentage(*args)
		a=args[0]
		item = TermCoefficient.new(a)
		percent = TermCoefficient.new(100*a)
		exp = Expression.new()
		exp.expressionItemList = [item,@eq,item,@times,TermCoefficient.new(100),@percent]
		@latexStringList << exp.toLatexString()
		exp[2]= TermFraction.new(percent,100)
		@latexStringList << exp.toLatexString()
		exp.expressionItemList = [item,@eq,percent,@percent]
		@latexStringList << exp.toLatexString()
	end

	def ratioToPercentage(*args)
		a=args[0];b=args[1]
		firstPart = TermCoefficient.new(((100*a.to_f)/(a+b)).round(2))
		secondPart = TermCoefficient.new(((100*b.to_f)/(a+b)).round(2))
		denExp = Expression.new()
		denExp.expressionItemList = [TermCoefficient.new(a),@add,TermCoefficient.new(b)]
		@latexStringList << " Total part is "+(a+b).to_s
		exp= Expression.new()
		exp.expressionItemList = [TermFraction.new(a,denExp),@times,TermCoefficient.new(100),@percent,@eq,firstPart]
		@latexStringList << " First percentage is "+exp.toLatexString()
		exp[0] = TermFraction.new(b,denExp)
		exp.expressionItemList.pop(1);exp.expressionItemList << secondPart
		@latexStringList << "First percentage is "+exp.toLatexString()
	end
	def calcProfitPercent(*args)
		profit=args[0];cost=args[1]
		percent = (profit.to_f*100/cost).round(2)
		exp = Expression.new()
		exp.expressionItemList = [TermFraction.new(profit,cost),@times,TermCoefficient.new(100),@eq,TermCoefficient.new(percent),@percent]
		@latexStringList << " Profit percent is = \\frac{Profit}{Cost} \\times 100 "+exp.toLatexString()
	end
	def calcProfit(*args)
		profitPercent=args[0];cost=args[1]
		profit = (profitPercent.to_f*cost)/100
		exp = Expression.new()
		exp.expressionItemList = [TermFraction.new(profitPercent,100),@times,TermCoefficient.new(cost),@eq,TermCoefficient.new(profit)]
		@latexStringList << " Profit = Profit \\% \\times Cost Price "
		@latexStringList << exp.toLatexString()
		@latexStringList << " Selling Price = Cost Price + Profit "
		@latexStringList << " Selling Price = "+cost.to_s+" + "+profit.to_s
		@latexStringList << " Selling Price = "+(cost+profit).to_s
	end
	def calcLossPercent(*args)
		loss=args[0];cost=args[1]
		percent = (loss.to_f*100/cost).round(2)
		exp = Expression.new()
		exp.expressionItemList = [TermFraction.new(loss,cost),@times,TermCoefficient.new(100),@eq,TermCoefficient.new(percent),@percent]
		@latexStringList << " Loss percent is = \\frac{Loss}{Cost} \\times 100 "+exp.toLatexString()
	end
	def calcLoss(*args)
		lossPercent=args[0];cost=args[1]
		loss = (lossPercent.to_f*cost)/100
		exp = Expression.new()
		exp.expressionItemList = [TermFraction.new(lossPercent,100),@times,TermCoefficient.new(cost),@eq,TermCoefficient.new(loss)]
		@latexStringList << " Loss = Loss \\% \\times Cost Price "
		@latexStringList << exp.toLatexString()
		@latexStringList << " Selling Price = Cost Price - Loss "
		@latexStringList << " Selling Price = "+cost.to_s+" - "+loss.to_s
		@latexStringList << " Selling Price = "+(cost-loss).to_s
	end
	def calcSimpleInterest(*args)
		sum=args[0];rate=args[1];yearCount=args[2]
		@latexStringList << " The sum borrowed = "+sum.to_s
		@latexStringList << " Rate of interest = "+rate.to_s+"\\% per year"
		interest = (sum.to_f*rate)/100
		exp = Expression.new()
		exp.expressionItemList = [@eq,TermFraction.new(15,100),@times,TermCoefficient.new(sum),@eq,TermCoefficient.new(interest)]
		@latexStringList << " The interest to paid after 1 year = "+exp.toLatexString()
		if yearCount>1
			interest = interest*yearCount
			exp.expressionItemList = [TermCoefficient.new(interest),@times,TermCoefficient.new(yearCount),@eq,TermCoefficient.new(interest)]
			@latexStringList << " The interest to paid after "+yearCount.to_s+" years = "+exp.toLatexString()
		end
		exp.expressionItemList = [TermCoefficient.new(sum),@add,TermCoefficient.new(interest),@eq,TermCoefficient.new(sum+interest)]

		@latexStringList << " The total amount to be paid after T years = A = P + I"
		@latexStringList << " Hence the total amount to be paid after "+yearCount.to_s+" years = "+exp.toLatexString()
	end
	def calcIncreaseFromPercent(*args)
		increasePercent=args[0];price=args[1]
		increase = (increasePercent.to_f*price)/100
		exp = Expression.new()
		exp.expressionItemList = [TermFraction.new(increasePercent,100),@times,TermCoefficient.new(price),@eq,TermCoefficient.new(increase)]
		@latexStringList << increasePercent.to_s+"\\% of "+ price.to_s + " =  "+ exp.toLatexString()
		@latexStringList << "New Price = Old Price + Increase"
		@latexStringList << "New Price = "+price.to_s+" + "+increase.to_s+" = "+(price+increase).to_s 
	end
	def calcDecreaseFromPercent(*args)
		decreasePercent=args[0];price=args[1]
		decrease = (decreasePercent.to_f*price)/100
		exp = Expression.new()
		exp.expressionItemList = [TermFraction.new(decreasePercent,100),@times,TermCoefficient.new(price),@eq,TermCoefficient.new(decrease)]
		@latexStringList << decreasePercent.to_s+"\\% of "+ price.to_s + " =  "+ exp.toLatexString()
		@latexStringList << "New Price = Old Price - Decrease"
		@latexStringList << "New Price = "+price.to_s+" - "+decrease.to_s+" = "+(price-decrease).to_s 
	end
	def calcDiscountPercent(*args)
		markedPrice=args[0];salesPrice=args[1]
		discount = markedPrice - salesPrice
		discountPercent = ((discount.to_f*100).to_f/markedPrice).round(2)
		@latexStringList << "Discount =  Marked Price - Sales Price"
		@latexStringList << "New Price = "+markedPrice.to_s+" - "+salesPrice.to_s+" = "+(markedPrice-salesPrice).to_s 
		exp = Expression.new()
		exp.expressionItemList = [TermFraction.new(discount,markedPrice),@times,TermCoefficient.new(100),@eq,TermCoefficient.new(discountPercent),@percent]
		@latexStringList << "Discount Percentage =  \\frac{Discount}{Marked Price}"
		@latexStringList << "Discount Percentage =  "+exp.toLatexString()
	end
	def calcSalesTax(*args)
		cost=args[0];rate=args[1]
		increase = (rate.to_f*cost)/100
		exp = Expression.new()
		exp.expressionItemList = [TermFraction.new(rate,100),@times,TermCoefficient.new(cost),@eq,TermCoefficient.new(increase)]
		@latexStringList << "On "+cost.to_s+", sales tax paid would be = "+ exp.toLatexString()
		@latexStringList << "Bill amount = Cost of item + Sales tax = "+cost.to_s+" + "+increase.to_s+" = "+(cost+increase).to_s
	end
	def calcVAT(*args)
		cost=args[0];rate=args[1]
		increasedRate = rate+100
		increase = ((cost.to_f*100)/increasedRate).round(2)
		@latexStringList << "The price includes the VAT, i.e., the value added tax. Thus, a "+rate.to_s+"\\% VAT means if the price without VAT is 100 then price including VAT is "+(increasedRate).to_s+". "
		@latexStringList << "Now, when price including VAT is "+(100+rate).to_s+", original price is  100."
		exp = Expression.new()
		exp.expressionItemList = [TermFraction.new(rate,increasedRate),@times,TermCoefficient.new(cost),@eq,TermCoefficient.new(increase)]
		@latexStringList << "Hence when price including tax is "+cost.to_s+", the original price "+ exp.toLatexString()
	end
	def calcCompoundInterest(*args)
		principal=args[0];rate=args[1];yearCount=args[2]
		increasedRate = rate+100
		frac = TermFraction.new(rate,100)
		exp=Expression.new()
		exp.expressionItemList=[TermCoefficient.new(1),@add,frac]
		exp.setExponent(yearCount)
		@latexStringList << "We have, A = P{(1 + \\frac{R}{100})}^{n} "
		@latexStringList << "where Principal(P)="+principal.to_s+", Rate(R)="+rate.to_s+",Number of years(n) = "+yearCount.to_s
		@latexStringList << "="+principal.to_s+exp.toLatexString()
		frac.baseNumerator= TermCoefficient.new(increasedRate) 
		frac.setExponent(yearCount)
		@latexStringList << "="+principal.to_s+frac.toLatexString()
		frac.setExponent(1)
		exp.expressionItemList = [TermCoefficient.new(principal)]
		for i in 1..yearCount
			exp.expressionItemList.concat([@times,frac])
		end
		amount = principal*(frac.calcFinalValue()**yearCount).round(2)
		exp.expressionItemList.concat([@eq,TermCoefficient.new(amount)])
		@latexStringList << "= "+exp.toLatexString()
		@latexStringList << "CI = A - P ="+amount.to_s+" - "+principal.to_s+" = "+(amount-principal).round(2).to_s

	end

end