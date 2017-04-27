require_relative '../exponent'
describe Exponent do
	context "When testing the Exponent class" do

		it "Initialize: should say '' when we check initialize method" do
			expo = Exponent.new()
			expect(expo.latexStringList.to_s).to eq "[]"
		end
		it "squareOneDigit: should say '' when we check squareOneDigit method" do
			expo = Exponent.new()
			expo.squareOneDigit(21)
			expect(expo.latexStringList.join(";").to_s).to eq "if a number has 1 in the unit’s place, then it’s square ends in 1."
		end
		it "squareOneDigit: should say '' when we check squareOneDigit method" do
			expo = Exponent.new()
			expo.squareOneDigit(129)
			expect(expo.latexStringList.join(";").to_s).to eq "if a number has 9 in the unit’s place, then it’s square ends in 1."
		end
		it "squareOneDigit: should say '' when we check squareOneDigit method" do
			expo = Exponent.new()
			expo.squareOneDigit(34)
			expect(expo.latexStringList.join(";").to_s).to eq "if a number has 4 in the unit’s place, then it’s square ends in 6."
		end
		it "squareOneDigit: should say '' when we check squareOneDigit method" do
			expo = Exponent.new()
			expo.squareOneDigit(56)
			expect(expo.latexStringList.join(";").to_s).to eq "if a number has 6 in the unit’s place, then it’s square ends in 6."
		end
		it "squareOneDigit: should say '' when we check squareOneDigit method" do
			expo = Exponent.new()
			expo.squareOneDigit(25)
			expect(expo.latexStringList.join(";").to_s).to eq "if a number has 5 in the unit’s place, then it’s square ends in 5."
		end
		it "squareOneDigit: should say '' when we check squareOneDigit method" do
			expo = Exponent.new()
			expo.squareOneDigit(23)
			expect(expo.latexStringList.join(";").to_s).to eq ""
		end
		it "squareValue: should say '' when we check squareOneDigit method" do
			expo = Exponent.new()
			expo.squareValue(25)
			expect(expo.latexStringList.join(";").to_s).to eq "25^{2}=25\\times25=625"
		end
		it "squareRootValue: should say '' when we check squareRootValue method" do
			expo = Exponent.new()
			expo.squareRootValue(25)
			expect(expo.latexStringList.join(";").to_s).to eq "We know that;5.0\\times5.0=25;5.0 is a square root of 25"
		end
=begin
		it "numSquareZero: should say '' when we check numSquareZero method" do
			expo = Exponent.new()
			expo.numSquareZero(200)
			expect(expo.latexStringList.join(";").to_s).to eq ""
		end
=end
		it "numNonSquareBetween: should say '' when we check numNonSquareBetween method" do
			expo = Exponent.new()
			expo.numNonSquareBetween(20)
			expect(expo.latexStringList.join(";").to_s).to eq "There are 2n non perfect square numbers between the squares of the numbers n and (n + 1).;Hence between 20^{2} and 21^{2} there are 2\\times20 non perfect square numbers "
		end
		it "calcSquareBracket: should say '' when we check calcSquareBracket method" do
			expo = Exponent.new()
			expo.calcSquareBracket(25)
			expect(expo.latexStringList.join(";").to_s).to eq "We know that for a number with unit digit 5, i.e., a5;{(a5)}^{2} = a(a+1) hunderd + 25"
		end
		it "calcSquareBracket: should say '' when we check calcSquareBracket method" do
			expo = Exponent.new()
			expo.calcSquareBracket(16)
			expect(expo.latexStringList.join(";").to_s).to eq "6^{2};{(6+6)}^{2};6(6+6)+6(6+6);6^{2}+6^{2}6^{2}+6^{2}6^{2}+6^{2};36+1296+1296+36;36"
		end
		it "calcRootPrime: should say '' when we check calcRootPrime method" do
			expo = Exponent.new()
			expo.calcRootPrime(576,true)
			expect(expo.latexStringList.join(";").to_s).to eq "Prime Factors of 576;2\\times2\\times2\\times2\\times2\\times2\\times3\\times3;2^{2}\\times2^{2}\\ti...es3^{2};{(2\\times2\\times2\\times3)}^{2};\\sqrt{576} = 2\\times2\\times2\\times31.4142135623730951"
		end
		it "calcRootPrime: should say '' when we check calcRootPrime method" do
			expo = Exponent.new()
			expo.calcRootPrime(256,true)
			expect(expo.latexStringList.join(";").to_s).to eq "Prime Factors of 256;2\\times2\\times2\\times2\\times2\\times2\\times2\\times2;2^{2}\\times2^{2}\\ti...es2^{2};{(2\\times2\\times2\\times2)}^{2};\\sqrt{256} = 2\\times2\\times2\\times21.4142135623730951"
		end
		it "calcRequiredNumberForRoot: should say '' when we check calcRequiredNumberForRoot method" do
			expo = Exponent.new()
			expo.calcRequiredNumberForRoot(9408,true,true)
			expect(expo.latexStringList.join(";").to_s).to eq "Prime Factors of a;2\\times2\\times2\\times2\\times2\\times2\\times3\\times7\\times7;2^{2}\\times2^{...s7^{2};{(2\\times2\\times2\\times7)}^{2};\\sqrt{3136} = 2\\times2\\times2\\times71.4142135623730951"
		end
		it "calcRequiredNumberForRoot: should say '' when we check calcRequiredNumberForRoot method" do
			expo = Exponent.new()
			expo.calcRequiredNumberForRoot(53240,true,false)
			expect(expo.latexStringList.join(";").to_s).to eq "Prime Factors of a;2\\times2\\times2\\times5\\times11\\times11\\times11;2^{2}\\times11^{2};We know t...times11\\times11;2^{3}\\times11^{3};{(2\\times11)}^{3};\\cbrt{10648} = 2\\times111.4422495703074083"
		end
		it "calcRequiredNumberForRoot: should say '' when we check calcRequiredNumberForRoot method" do
			expo = Exponent.new()
			expo.calcRequiredNumberForRoot(2352,false,true)
			expect(expo.latexStringList.join(";").to_s).to eq "Prime Factors of a;2\\times2\\times2\\times2\\times3\\times7\\times7;2^{2}\\times2^{2}\\times7^{2};W...s7^{2};{(2\\times2\\times3\\times7)}^{2};\\sqrt{7056} = 2\\times2\\times3\\times71.4142135623730951"
		end
		it "calcRequiredNumberForRoot: should say '' when we check calcRequiredNumberForRoot method" do
			expo = Exponent.new()
			expo.calcRequiredNumberForRoot(392,false,false)
			expect(expo.latexStringList.join(";").to_s).to eq "Prime Factors of a;2\\times2\\times2\\times7\\times7;2^{2}\\times7^{2};We know that prime factors  a...es7\\times7\\times7;2^{3}\\times7^{3};{(2\\times7)}^{3};\\cbrt{19208} = 2\\times71.4422495703074083"
		end
		it "estimateSquareRoot: should say '' when we check estimateSquareRoot method" do
			expo = Exponent.new()
			expo.estimateSquareRoot(250)
			expect(expo.latexStringList.join(";").to_s).to eq "100<250<400&100=10^{2}&400=20^{2};100<\\sqrt{250}<400;But still we are not very close to the square number;225<250<256&225=15^{2}&256=16^{2};225<\\sqrt{250}<256;\\sqrt{250} is approximately 16"
		end
		it "calcExponentValue: should say '' when we check calcExponentValue method" do
			expo = Exponent.new()
			expo.calcExponentValue(3,2,true)
			expect(expo.latexStringList.join(";").to_s).to eq "\\frac{1}{3^{2}}=\\frac{1}{3\\times3\\times3}=\\frac{1}{9};\\frac{1}{3^{2}}=\\frac{1}{3\\times3\\times3}=\\frac{1}{9}"
		end
		it "calcExponentValue: should say '' when we check calcExponentValue method" do
			expo = Exponent.new()
			expo.calcExponentValue(3,-2,true)
			expect(expo.latexStringList.join(";").to_s).to eq "\\frac{1}{3^{-2}}=3^{2};=9"
		end
		it "calcExponentValue: should say '' when we check calcExponentValue method" do
			expo = Exponent.new()
			expo.calcExponentValue(3,2,false)
			expect(expo.latexStringList.join(";").to_s).to eq "=9"
		end
		it "calcExponentValue: should say '' when we check calcExponentValue method" do
			expo = Exponent.new()
			expo.calcExponentValue(3,-2,true)
			expect(expo.latexStringList.join(";").to_s).to eq "\\frac{1}{3^{-2}}=3^{2};=9"
		end
		it "expressUsingExponent: should say '' when we check expressUsingExponent method" do
			expo = Exponent.new()
			expo.expressUsingExponent(1.2)
			puts expo.latexStringList.join(";").to_s
			expect(expo.latexStringList.join(";").to_s).to eq "1025.63=+1\\times1000+0\\times100+2\\times10+5\\times1+\\frac{0}{10}+\\frac{0}{100}+\\frac{6}{1000}+...12}+0\\times10^{13}+0\\times10^{14}+1\\times10^{15}+0\\times10^{16}+9\\times10^{17}+1\\times10^{18}"
		end
		it "simplifyExponentValue: should say '' when we check simplifyExponentValue method" do
			expo = Exponent.new()
			expo.simplifyExponentValue(2,3,2,4,false,true)
			expect(expo.latexStringList.join(";").to_s).to eq "2^{3}\\times2^{4}=2^{3+4}=2^{7}"
		end
		it "simplifyExponentValue: should say '' when we check simplifyExponentValue method" do
			expo = Exponent.new()
			expo.simplifyExponentValue(-2,3,-2,4,false,true)
			expect(expo.latexStringList.join(";").to_s).to eq "(-2)^{3}\\times(-2)^{4}=(-2)^{3+4}=(-2)^{7}"
		end
		it "simplifyExponentValue: should say '' when we check simplifyExponentValue method" do
			expo = Exponent.new()
			expo.simplifyExponentValue(2,3,5,3,false,true)
			expect(expo.latexStringList.join(";").to_s).to eq "2^{3}\\times5^{3}={(2\\times5)}^{3}=10^{3}"
		end
		it "simplifyExponentValue: should say '' when we check simplifyExponentValue method" do
			expo = Exponent.new()
			expo.simplifyExponentValue(2,-3,5,-3,false,true)
			expect(expo.latexStringList.join(";").to_s).to eq "2^{-3}\\times5^{-3}={(2\\times5)}^{-3}=10^{-3}"
		end
		it "simplifyExponentValue: should say '' when we check simplifyExponentValue method" do
			expo = Exponent.new()
			expo.simplifyExponentValue(2,3,2,4,false,false)
			expect(expo.latexStringList.join(";").to_s).to eq "2^{3}\\div\\frac{1}{2^{4}}=2^{3-4}=2^{-1}"
		end
		it "simplifyExponentValue: should say '' when we check simplifyExponentValue method" do
			expo = Exponent.new()
			expo.simplifyExponentValue(-2,3,-2,4,false,false)
			expect(expo.latexStringList.join(";").to_s).to eq "(-2)^{3}\\div\\frac{1}{-2^{4}}=(-2)^{3-4}=(-2)^{-1}"
		end
		it "simplifyExponentValue: should say '' when we check simplifyExponentValue method" do
			expo = Exponent.new()
			expo.simplifyExponentValue(2,3,5,3,false,false)
			expect(expo.latexStringList.join(";").to_s).to eq "2^{3}\\div5^{3}={(\\frac{2}{5})}^{3}=\\frac{8}{125}"
		end
		it "simplifyExponentValue: should say '' when we check simplifyExponentValue method" do
			expo = Exponent.new()
			expo.simplifyExponentValue(2,-3,5,-3,false,false)
			expect(expo.latexStringList.join(";").to_s).to eq "2^{-3}\\div5^{-3}={(\\frac{2}{5})}^{-3}=\\frac{125/1}{8/1}"
		end

		it "simplifyExponentValue: should say '' when we check simplifyExponentValue method" do
			expo = Exponent.new()
			expo.simplifyExponentValue(2,3,2,4,false,true)
			expect(expo.latexStringList.join(";").to_s).to eq "2^{3}\\times2^{4}=2^{3+4}=2^{7}"
		end
		it "simplifyExponentValue: should say '' when we check simplifyExponentValue method" do
			expo = Exponent.new()
			expo.simplifyExponentValue(-2,3,-2,4,false,true)
			expect(expo.latexStringList.join(";").to_s).to eq "(-2)^{3}\\times(-2)^{4}=(-2)^{3+4}=(-2)^{7}"
		end
		it "simplifyExponentValue: should say '' when we check simplifyExponentValue method" do
			expo = Exponent.new()
			expo.simplifyExponentValue(2,3,5,3,true,true)
			expect(expo.latexStringList.join(";").to_s).to eq "2^{3}\\times5^{3}={(2\\times5)}^{3}=10^{3};=1000"
		end
		it "simplifyExponentValue: should say '' when we check simplifyExponentValue method" do
			expo = Exponent.new()
			expo.simplifyExponentValue(2,-3,5,-3,true,true)
			expect(expo.latexStringList.join(";").to_s).to eq "2^{-3}\\times5^{-3}={(2\\times5)}^{-3}=10^{-3};10^{-3}=\\frac{1}{10^{3}}=\\frac{1}{10}=\\frac{1}{1000};10^{-3}=\\frac{1}{10^{3}}=\\frac{1}{10}=\\frac{1}{1000}"
		end
		it "simplifyExponentValue: should say '' when we check simplifyExponentValue method" do
			expo = Exponent.new()
			expo.simplifyExponentValue(2,3,2,4,true,false)
			expect(expo.latexStringList.join(";").to_s).to eq "2^{3}\\div\\frac{1}{2^{4}}=2^{3-4}=2^{-1};2^{-1}=\\frac{1}{2}=\\frac{1}{2}=\\frac{1}{2};2^{-1}=\\frac{1}{2}=\\frac{1}{2}=\\frac{1}{2}"
		end
		it "simplifyExponentValue: should say '' when we check simplifyExponentValue method" do
			expo = Exponent.new()
			expo.simplifyExponentValue(-2,3,-2,4,true,false)
			expect(expo.latexStringList.join(";").to_s).to eq "(-2)^{3}\\div\\frac{1}{-2^{4}}=(-2)^{3-4}=(-2)^{-1};2^{-1}=\\frac{1}{2}=\\frac{1}{2}=\\frac{1}{2};2^{-1}=\\frac{1}{2}=\\frac{1}{2}=\\frac{1}{2}"
		end
		it "simplifyExponentValue: should say '' when we check simplifyExponentValue method" do
			expo = Exponent.new()
			expo.simplifyExponentValue(2,3,5,3,true,false)
			expect(expo.latexStringList.join(";").to_s).to eq "2^{3}\\div5^{3}={(\\frac{2}{5})}^{3}=\\frac{8}{125};\\frac{1}{0.064}=\\frac{1}{0.064\\times0.064}=\\frac{1}{0.064};\\frac{1}{0.064}=\\frac{1}{0.064\\times0.064}=\\frac{1}{0.064}"
		end
		it "simplifyExponentValue: should say '' when we check simplifyExponentValue method" do
			expo = Exponent.new()
			expo.simplifyExponentValue(2,-3,5,-3,true,false)
			expect(expo.latexStringList.join(";").to_s).to eq "2^{-3}\\div5^{-3}={(\\frac{2}{5})}^{-3}=\\frac{125/1}{8/1};\\frac{1}{15.625}=\\frac{1}{15.625\\times15.625}=\\frac{1}{15.625};\\frac{1}{15.625}=\\frac{1}{15.625\\times15.625}=\\frac{1}{15.625}"
		end

		it "exponentialForm: should say '' when we check exponentialForm method" do
			expo = Exponent.new()
			expo.exponentialForm(12900000)
			expect(expo.latexStringList.join(";").to_s).to eq "12900000=1\\times10000000;12900000=1\\times10^{7}"
		end

		it "exponentialForm: should say '' when we check exponentialForm method" do
			expo = Exponent.new()
			expo.exponentialForm(0.00078)
			expect(expo.latexStringList.join(";").to_s).to eq "0.00078=\\frac{7.8}{1/10000};0.00078=\\frac{7.8}{10^{-4}};0.00078=7.8\\times10^{-4}"
		end
		it "exponentToUsualForm: should say '' when we check exponentToUsualForm method" do
			expo = Exponent.new()
			expo.exponentToUsualForm(1.4,9)
			expect(expo.latexStringList.join(";").to_s).to eq "1.4\\times10^{9}=1.4\\times1000000000;1.4\\times10^{9}=1400000000.0"
		end
		it "exponentToUsualForm: should say '' when we check exponentToUsualForm method" do
			expo = Exponent.new()
			expo.exponentToUsualForm(7,-6)
			expect(expo.latexStringList.join(";").to_s).to eq "7\\times10^{-6}=7\\times1/1000000;7\\times10^{-6}=7/1000000"
		end
# =end
		
	end
end