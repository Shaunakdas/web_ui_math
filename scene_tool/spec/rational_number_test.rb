require_relative '../rational_number'
describe RationalNumber do
	context "When testing the Rational Number class" do

		it "Initialize: should say '' when we check initialize method" do
			rational = RationalNumber.new()
			expect(rational.latexStringList.to_s).to eq "[]"
		end

		it "solveLinearEqWithVariableOnLeftSide: should say '' when we check this method" do
			rational = RationalNumber.new()
			rational.solveLinearEqWithVariableOnLeftSide(1,2,3,1,2,3,"x","+")
			expect(rational.latexStringList.join(";").to_s).to eq "x+3=\\frac{2}{3};Transposing 3to RHS;x=\\frac{2}{3}-3;x=(-\\frac{7}{3});Required Solution ;To check the answer: LHS =x+3= x+3= = RHS (as required)"
		end

		it "solveLinearEqWithVariableOnBothSides: should say '' when we check this method" do
			rational = RationalNumber.new()
			rational.solveLinearEqWithVariableOnBothSides(1,2,3,1,2,3,1,2,"x","+","+")
			expect(rational.latexStringList.join(";").to_s).to eq "[]"
		end
=begin
		it "equivalentRationalNumber: should say '' when we check this method" do
			rational = RationalNumber.new()
			rational.equivalentRationalNumber(1,2,4,true)
			expect(rational.latexStringList.join(";").to_s).to eq "We know 2\times2=4;This means we need to multiply both the numerator and denominator by 2to get the equivalent fraction;Hence ;\frac{1}{2}=\frac{1\times2}{2\times2};\frac{1}{2}=\frac{2}{4};\frac{2}{4} is required equivalent fraction"
		end

		it "equivalentRationalNumberSmall: should say '' when we check this method" do
			rational = RationalNumber.new()
			rational.equivalentRationalNumberSmall(1,2,4)
			expect(rational.latexStringList.join(";").to_s).to eq "\\frac{1}{2}=\\frac{1\\times2}{2\\times2}=\\frac{2}{4}"
		end

		it "simplestForm: should say '' when we check this method" do
			rational = RationalNumber.new()
			rational.simplestForm(1,2)
			expect(rational.latexStringList.join(";").to_s).to eq "Shortest way to find equivalent fraction in simplest form is to find HCF of numerator and denominator and divide them by HCF;HCF of 1 and 2 is 1;\frac{1}{2};\frac{1}{2}=\frac{1}{2};The fraction \frac{1}{2}"
		end
		it "simplestFormSmall: should say '' when we check this method" do
			rational = RationalNumber.new()
			rational.simplestFormSmall(1,2)
			expect(rational.latexStringList.join(";").to_s).to eq "\\frac{1}{2}=\\frac{1\\div1}{2\\div1}=\\frac{1}{2}"
		end
		it "negativeFlag: should say '' when we check this method" do
			rational = RationalNumber.new()
			rational.negativeFlag(1,2)
			expect(rational.latexStringList.join(";").to_s).to eq "Both the numerator and denominator of this number are positive integers. Such a rational number is called a positive rational number"
		end

		it "compare: should say '' when we check this method" do
			rational = RationalNumber.new()
			rational.compare(1,2,4,5)
			expect(rational.latexStringList.join(";").to_s).to eq "\\frac{1}{2}=\frac{1\div1}{2\div1}=\frac{1}{2};\frac{4}{5}=\frac{4\div1}{5\div1}=\frac{4}{5};The fractions are unlike. We should first get their equivalent fractions with a denominator which is a LCM of 2 and 5.;\frac{1}{2}=\frac{1\times5}{2\times5}=\frac{5}{10};\frac{4}{5}=\frac{4\times2}{5\times2}=\frac{8}{10};Both are like fraction.;In both the fractions the whole is divided into 10 equal parts. For we take 5 and 8 parts respectively out of the 10 equal parts. ;Clearly, out of 10 equal parts, the portion corresponding to 8 parts is larger than the portion corresponding to 5 parts.;\frac{8}{10}>\frac{5}{10};\frac{4}{5}>\frac{1}{2}"
		end

		it "compareFraction: should say '' when we check this method" do
			rational = RationalNumber.new()
			rational.compareFraction(1,2,4,5)
			expect(rational.latexStringList.join(";").to_s).to eq "The fractions are unlike. We should first get their equivalent fractions with a denominator which is...er than the portion corresponding to 5 parts.;\\frac{8}{10}>\\frac{5}{10};\\frac{4}{5}>\\frac{1}{2}"
		end

		it "addFraction: should say '' when we check this method" do
			rational = RationalNumber.new()
			rational.addFraction(1,2,4,5)
			puts rational.latexStringList.join(";").to_s
			expect(rational.latexStringList.join(";").to_s).to eq "The fractions are unlike. We should first get their equivalent fractions with a denominator which is a LCM of 2 and 5.;\frac{1}{2}=\frac{1\times5}{2\times5}=\frac{5}{10};\frac{4}{5}=\frac{4\times2}{5\times2}=\frac{8}{10};Both are like fraction.The sum of two or more like fractions can be obtained as follows;Retain the (common) denominator and add the numerators;\frac{5}{10}+\frac{8}{10}=\frac{5+8}{10}=\frac{13}{10}"
		end

		it "subtractFraction: should say '' when we check this method" do
			rational = RationalNumber.new()
			rational.subtractFraction(1,2,4,5)
			puts rational.latexStringList.join(";").to_s
			expect(rational.latexStringList.join(";").to_s).to eq "The fractions are unlike. We should first get their equivalent fractions with a denominator which is a LCM of 2 and 5.;\frac{1}{2}=\frac{1\times5}{2\times5}=\frac{5}{10};\frac{4}{5}=\frac{4\times2}{5\times2}=\frac{8}{10};Both are like fraction.The difference of two like fractions can be obtained as follows;Retain the (common) denominator and subtract the numerators;\frac{5}{10}-\frac{8}{10}=\frac{5-8}{10}=(-\frac{3}{10})"
		end

		it "additiveInverse: should say '' when we check this method" do
			rational = RationalNumber.new()
			rational.additiveInverse(1,2)
			expect(rational.latexStringList.join(";").to_s).to eq "\\frac{1}{2}+(-\\frac{1}{2})=\\frac{1+1}{2}=\\frac{0}{2}=0"
		end

		it "multiplicativeInverse: should say '' when we check this method" do
			rational = RationalNumber.new()
			rational.multiplicativeInverse(1,2)
			expect(rational.latexStringList.join(";").to_s).to eq "\\frac{1}{2}must be multiplied by\\frac{2}{1}so as to get product 1 because \\frac{1}{2}\\times\\frac{2}{1}=1"
		end	
=end
	end
end