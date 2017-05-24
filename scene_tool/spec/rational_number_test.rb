require_relative '../rational_number'
describe RationalNumber do
	context "When testing the Rational Number class" do

		it "Initialize: should say '' when we check initialize method" do
			rational = RationalNumber.new()
			expect(rational.latexStringList.to_s).to eq "[]"
		end

		it "solveLinearEqWithVariableOnLeftSide: should say '' when we check this method" do
			rational = RationalNumber.new()
			rational.ratNum_solveLinearEqWithVariableOnLeftSide(1,2,3,1,2,3,"x","+")
			puts rational.latexStringList.join(";").to_s
			expect(rational.latexStringList.join(";").to_s).to eq "\\frac{1}{2}x+3=\\frac{2}{3};Transposing 3to RHS;\\frac{1}{2}x=\\frac{2}{3}-3;\\frac{1}{2}x=(-\\frac{7}{3});Multiplying both sides by 2;x=(-\\frac{7}{3})\\times2;x=(-\\frac{14}{3});Required Solution ;To check the answer: LHS =(\\frac{1}{2})+3= (\\frac{1}{2})+3= (\\frac{7}{2})= RHS (as required)"
		end
		it "solveLinearEqWithVariableOnBothSides: should say '' when we check this method" do
			rational = RationalNumber.new()
			rational.ratNum_solveLinearEqWithVariableOnBothSides(1,2,3,1,2,3,1,2,"x","+","+")
			puts rational.latexStringList.join(";").to_s
			expect(rational.latexStringList.join(";").to_s).to eq "\\frac{1}{2}x+3=\\frac{2}{3}x+\\frac{1}{2};Transposing \\frac{2}{3}xto LHS;\\frac{1}{2}x+3-\\frac{2}{3}x=\\frac{1}{2};x(\\frac{1}{2}-\\frac{2}{3})+3=\\frac{1}{2};x(\\frac{1}{2}-\\frac{2}{3})+3=\\frac{1}{2};(-\\frac{1}{6})x+3=\\frac{2}{3}x;(-\\frac{1}{6})x+3=\\frac{1}{2};Transposing 3to RHS;(-\\frac{1}{6})x=\\frac{1}{2}-3;(-\\frac{1}{6})x=(-\\frac{5}{2});Multiplying both sides by 6;x=(-\\frac{5}{2})\\times6;x=\\frac{30}{2};Required Solution ;To check the answer: LHS =(-\\frac{1}{6})+3= -(\\frac{1}{6})+3= -(\\frac{19}{6})= RHS (as required)"
		end

		it "equivalentRationalNumber: should say '' when we check this method" do
			rational = RationalNumber.new()
			rational.ratNum_equivalentRationalNumber(1,2,4,true)
			puts rational.latexStringList.join(";").to_s
			expect(rational.latexStringList.join(";").to_s).to eq "We know 2\\times2=4;This means we need to multiply both the numerator and denominator by 2to get the equivalent fraction;Hence ;\\frac{1}{2}=\\frac{1\\times2}{2\\times2};\\frac{1}{2}=\\frac{2}{4};\\frac{2}{4} is required equivalent fraction"
		end

		it "equivalentRationalNumberSmall: should say '' when we check this method" do
			rational = RationalNumber.new()
			rational.ratNum_equivalentRationalNumberSmall(1,2,4)
			expect(rational.latexStringList.join(";").to_s).to eq "\\frac{1}{2}=\\frac{1\\times2}{2\\times2}=\\frac{2}{4}"
		end

		it "simplestForm: should say '' when we check this method" do
			rational = RationalNumber.new()
			rational.ratNum_simplestForm(1,2)
			puts rational.latexStringList.join(";").to_s
			expect(rational.latexStringList.join(";").to_s).to eq "Shortest way to find equivalent fraction in simplest form is to find HCF of numerator and denominator and divide them by HCF;HCF of 1 and 2 is 1;\\frac{1}{2};\\frac{1}{2}=\\frac{1}{2};The fraction \\frac{1}{2}"
		end
		it "simplestFormSmall: should say '' when we check this method" do
			rational = RationalNumber.new()
			rational.ratNum_simplestFormSmall(1,2)
			expect(rational.latexStringList.join(";").to_s).to eq "\\frac{1}{2}=\\frac{1\\div1}{2\\div1}=\\frac{1}{2}"
		end
		it "negativeFlag: should say '' when we check this method" do
			rational = RationalNumber.new()
			rational.ratNum_negativeFlag(1,2)
			expect(rational.latexStringList.join(";").to_s).to eq "Both the numerator and denominator of this number are positive integers. Such a rational number is called a positive rational number"
		end

		it "compare: should say '' when we check this method" do
			rational = RationalNumber.new()
			rational.ratNum_compare(1,2,4,5)
			expect(rational.latexStringList.join(";").to_s).to eq "\\frac{1}{2}=\\frac{1\\div1}{2\\div1}=\\frac{1}{2};\\frac{4}{5}=\\frac{4\\div1}{5\\div1}=\\frac{4}{5};The fractions are unlike. We should first get their equivalent fractions with a denominator which is a LCM of 2 and 5.;\\frac{1}{2}=\\frac{1\\times5}{2\\times5}=\\frac{5}{10};\\frac{4}{5}=\\frac{4\\times2}{5\\times2}=\\frac{8}{10};Both are like fraction.;In both the fractions the whole is divided into 10 equal parts. For we take 5 and 8 parts respectively out of the 10 equal parts. ;Clearly, out of 10 equal parts, the portion corresponding to 8 parts is larger than the portion corresponding to 5 parts.;\\frac{8}{10}>\\frac{5}{10};\\frac{4}{5}>\\frac{1}{2}"
		end

		it "compareFraction: should say '' when we check this method" do
			rational = RationalNumber.new()
			rational.ratNum_compareFraction(1,2,4,5)
			puts rational.latexStringList.join(";").to_s
			expect(rational.latexStringList.join(";").to_s).to eq "The fractions are unlike. We should first get their equivalent fractions with a denominator which is a LCM of 2 and 5.;\\frac{1}{2}=\\frac{1\\times5}{2\\times5}=\\frac{5}{10};\\frac{4}{5}=\\frac{4\\times2}{5\\times2}=\\frac{8}{10};Both are like fraction.;In both the fractions the whole is divided into 10 equal parts. For we take 5 and 8 parts respectively out of the 10 equal parts. ;Clearly, out of 10 equal parts, the portion corresponding to 8 parts is larger than the portion corresponding to 5 parts.;\\frac{8}{10}>\\frac{5}{10};\\frac{4}{5}>\\frac{1}{2}"
		end

		it "addFraction: should say '' when we check this method" do
			rational = RationalNumber.new()
			rational.ratNum_addFraction(1,2,4,5)
			# puts rational.latexStringList.join(";").to_s
			expect(rational.latexStringList.join(";").to_s).to eq "The fractions are unlike. We should first get their equivalent fractions with a denominator which is a LCM of 2 and 5.;\\frac{1}{2}=\\frac{1\\times5}{2\\times5}=\\frac{5}{10};\\frac{4}{5}=\\frac{4\\times2}{5\\times2}=\\frac{8}{10};Both are like fraction.The sum of two or more like fractions can be obtained as follows;Retain the (common) denominator and add the numerators;\\frac{5}{10}+\\frac{8}{10}=\\frac{5+8}{10}=\\frac{13}{10}"
		end

		it "subtractFraction: should say '' when we check this method" do
			rational = RationalNumber.new()
			rational.ratNum_subtractFraction(1,2,4,5)
			# puts rational.latexStringList.join(";").to_s
			expect(rational.latexStringList.join(";").to_s).to eq "The fractions are unlike. We should first get their equivalent fractions with a denominator which is a LCM of 2 and 5.;\\frac{1}{2}=\\frac{1\\times5}{2\\times5}=\\frac{5}{10};\\frac{4}{5}=\\frac{4\\times2}{5\\times2}=\\frac{8}{10};Both are like fraction.The difference of two like fractions can be obtained as follows;Retain the (common) denominator and subtract the numerators;\\frac{5}{10}-\\frac{8}{10}=\\frac{5-8}{10}=(-\\frac{3}{10})"
		end
		it "ratNum_convertMixedImproperLarge: should say '' when we check this method" do
			rational = RationalNumber.new()
			rational.ratNum_convertMixedImproperLarge(7,1,9)
			# puts rational.latexStringList.join(";").to_s
			expect(rational.latexStringList.join(";").to_s).to eq "we can express a mixed fraction as an improper fraction as \n \\frac{(Whole\\timesDenominator)+Numerator}{Denominator}.;7\\frac{1}{9}=\\frac{(7\\times9)+1}{9}=\\frac{64}{9}"
		end
		it "ratNum_convertMixedImproperLarge: should say '' when we check this method" do
			rational = RationalNumber.new()
			rational.ratNum_convertMixedImproperLarge(17,4)
			puts rational.latexStringList.join(";").to_s
			expect(rational.latexStringList.join(";").to_s).to eq "We can express an improper fraction as a mixed fraction by dividing the numerator by denominator to obtain the quotient and the remainder.Then the mixed fraction will be written as Quotient \\frac{Remainder}{Divisor};For 17\\div4, Quotient= 4 and Remainder=1;\\frac{17}{4} = 4\\frac{1}{4}"
		end
		it "ratNum_convertMixedImproperSmall: should say '' when we check this method" do
			rational = RationalNumber.new()
			rational.ratNum_convertMixedImproperSmall(7,1,9)
			# puts rational.latexStringList.join(";").to_s
			expect(rational.latexStringList.join(";").to_s).to eq "7\\frac{1}{9}=\\frac{(7\\times9)+1}{9}=\\frac{64}{9}"
		end
		it "ratNum_convertMixedImproperSmall: should say '' when we check this method" do
			rational = RationalNumber.new()
			rational.ratNum_convertMixedImproperSmall(17,4)
			puts rational.latexStringList.join(";").to_s
			expect(rational.latexStringList.join(";").to_s).to eq "\\frac{17}{4} = \\frac{16+1}{4} = 4+\\frac{1}{4}=4\\frac{1}{4}"
		end
		it "ratNum_addMixedFraction: should say '' when we check this method" do
			rational = RationalNumber.new()
			rational.ratNum_addMixedFraction(2,4,5,3,5,6)
			puts rational.latexStringList.join(";").to_s
			expect(rational.latexStringList.join(";").to_s).to eq "2\\frac{4}{5}+3\\frac{5}{6}=2+\\frac{4}{5}+3+\\frac{5}{6}=5+\\frac{4}{5}+\\frac{5}{6};The fractions are unlike. We should first get their equivalent fractions with a denominator which is a LCM of 5 and 6.;\\frac{4}{5}=\\frac{4\\times6}{5\\times6}=\\frac{24}{30};\\frac{5}{6}=\\frac{5\\times5}{6\\times5}=\\frac{25}{30};Both are like fraction.The sum of two or more like fractions can be obtained as follows;Retain the (common) denominator and add the numerators;\\frac{24}{30}+\\frac{25}{30}=\\frac{24+25}{30}=\\frac{49}{30};\\frac{49}{30} = \\frac{30+19}{30} = 1+\\frac{19}{30}=1\\frac{19}{30};2\\frac{4}{5}+3\\frac{5}{6} = 5+1+\\frac{19}{30}=6\\frac{19}{30}"
		end
		it "ratNum_subtractMixedFraction: should say '' when we check this method" do
			rational = RationalNumber.new()
			rational.ratNum_subtractMixedFraction(8,1,4,2,5,6)
			puts rational.latexStringList.join(";").to_s
			expect(rational.latexStringList.join(";").to_s).to eq "As 8>2 and \\frac{1}{4}<\\frac{5}{6}, we convert both the fractions into improper fractions and subtract them;8\\frac{1}{4}=\\frac{(8\\times4)+1}{4}=\\frac{33}{4};2\\frac{5}{6}=\\frac{(2\\times6)+5}{6}=\\frac{17}{6};The fractions are unlike. We should first get their equivalent fractions with a denominator which is a LCM of 4 and 6.;\\frac{33}{4}=\\frac{33\\times3}{4\\times3}=\\frac{99}{12};\\frac{17}{6}=\\frac{17\\times2}{6\\times2}=\\frac{34}{12};Both are like fraction.The difference of two like fractions can be obtained as follows;Retain the (common) denominator and subtract the numerators;\\frac{99}{12}-\\frac{34}{12}=\\frac{99-34}{12}=\\frac{65}{12};\\frac{65}{12} = \\frac{60+5}{12} = 5+\\frac{5}{12}=5\\frac{5}{12}"
		end
		it "ratNum_subtractMixedFraction: should say '' when we check this method" do
			rational = RationalNumber.new()
			rational.ratNum_subtractMixedFraction(4,2,5,2,1,5)
			puts rational.latexStringList.join(";").to_s
			expect(rational.latexStringList.join(";").to_s).to eq "As 4>2 and \\frac{2}{5}>\\frac{1}{5},;The whole numbers 4 and 2 and the fractional numbers \\frac{2}{5} and \\frac{1}{5} can be subtracted separately.;4\\frac{2}{5}-2\\frac{1}{5}=(4-2)+(\\frac{2}{5}-\\frac{1}{5})=2+\\frac{1}{5}=2\\frac{1}{5}"
		end

		it "additiveInverse: should say '' when we check this method" do
			rational = RationalNumber.new()
			rational.ratNum_additiveInverse(1,2)
			expect(rational.latexStringList.join(";").to_s).to eq "\\frac{1}{2}+(-\\frac{1}{2})=\\frac{1+1}{2}=\\frac{0}{2}=0"
		end

		it "multiplicativeInverse: should say '' when we check this method" do
			rational = RationalNumber.new()
			rational.ratNum_multiplicativeInverse(1,2)
			expect(rational.latexStringList.join(";").to_s).to eq "\\frac{1}{2}must be multiplied by2so as to get product 1 because \\frac{1}{2}\\times2=1"
		end	

		it "ratNum_productRationalWholeLarge: should say '' when we check this method" do
			rational = RationalNumber.new()
			rational.ratNum_productRationalWholeLarge(3,2,5)
			expect(rational.latexStringList.join(";").to_s).to eq "3\\times\\frac{2}{5}=\\frac{2}{5}+\\frac{2}{5}+\\frac{2}{5}=\\frac{3\\times2}{5}=\\frac{6}{5}"
		end

		it "ratNum_productRationalWholeSmall: should say '' when we check this method" do
			rational = RationalNumber.new()
			rational.ratNum_productRationalWholeSmall(4,2,5)
			expect(rational.latexStringList.join(";").to_s).to eq "4\\times\\frac{2}{5}=\\frac{4\\times2}{5}=\\frac{8}{5}"
		end

		it "ratNum_productMixedFracWhole: should say '' when we check this method" do
			rational = RationalNumber.new()
			rational.ratNum_productMixedFracWhole(4,1,1,5)
			puts rational.latexStringList.join(";").to_s
			expect(rational.latexStringList.join(";").to_s).to eq "To multiply a mixed fraction to a whole number, first convert the mixed fraction to an improper fraction and then multiply.;4\\times1\\frac{1}{5}=4\\times\\frac{6}{5}=\\frac{4\\times1}{5}=\\frac{24}{5}"
		end

		it "ratNum_productProperFracSmall: should say '' when we check this method" do
			rational = RationalNumber.new()
			rational.ratNum_productProperFracSmall(1,2,3,4)
			expect(rational.latexStringList.join(";").to_s).to eq "\\frac{1}{2}\\times\\frac{3}{4}=\\frac{1\\times3}{2\\times4}=\\frac{3}{8}"
		end

		it "ratNum_productMixedFrac: should say '' when we check this method" do
			rational = RationalNumber.new()
			rational.ratNum_productMixedFrac(1,2,5,3,4,6)
			expect(rational.latexStringList.join(";").to_s).to eq "To multiply a mixed fraction to another Fraction, first convert the mixed fraction to an improper fraction and then multiply.;1\\frac{2}{5}\\times3\\frac{4}{6}=\\frac{7}{5}\\times\\frac{22}{6}=\\frac{7\\times22}{5\\times6}=\\frac{154}{30}"
		end

		it "ratNum_divisionProperFracSmall: should say '' when we check this method" do
			rational = RationalNumber.new()
			rational.ratNum_divisionProperFracSmall(1,2,4,3)
			expect(rational.latexStringList.join(";").to_s).to eq "\\frac{1}{2}\\div\\frac{4}{3}=\\frac{1}{2}\\times reciprocal of \\frac{4}{3};\\frac{1}{2}\\times\\frac{3}{4}=\\frac{1\\times3}{2\\times4}=\\frac{3}{8}"
		end

	end
end