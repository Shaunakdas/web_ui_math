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
			expect(rational.latexStringList.join(";").to_s).to eq "[]"
		end
		it "solveLinearEqWithVariableOnBothSides: should say '' when we check this method" do
			rational = RationalNumber.new()
			rational.solveLinearEqWithVariableOnBothSides(1,2,3,1,2,3,1,2,"x","+","+")
			expect(rational.latexStringList.join(";").to_s).to eq "[]"
		end
		it "equivalentRationalNumber: should say '' when we check this method" do
			rational = RationalNumber.new()
			rational.equivalentRationalNumber(1,2,4,true)
			expect(rational.latexStringList.join(";").to_s).to eq "[]"
		end
		it "equivalentRationalNumberSmall: should say '' when we check this method" do
			rational = RationalNumber.new()
			rational.equivalentRationalNumberSmall(1,2,4)
			expect(rational.latexStringList.join(";").to_s).to eq "[]"
		end
		it "simplestForm: should say '' when we check this method" do
			rational = RationalNumber.new()
			rational.simplestForm(1,2)
			expect(rational.latexStringList.join(";").to_s).to eq "[]"
		end
		it "simplestFormSmall: should say '' when we check this method" do
			rational = RationalNumber.new()
			rational.simplestFormSmall(1,2)
			expect(rational.latexStringList.join(";").to_s).to eq "[]"
		end
		it "negativeFlag: should say '' when we check this method" do
			rational = RationalNumber.new()
			rational.negativeFlag(1,2)
			expect(rational.latexStringList.join(";").to_s).to eq "[]"
		end
		it "compare: should say '' when we check this method" do
			rational = RationalNumber.new()
			rational.compare(1,2,4,5)
			expect(rational.latexStringList.join(";").to_s).to eq "[]"
		end
		it "compareFraction: should say '' when we check this method" do
			rational = RationalNumber.new()
			rational.compareFraction(1,2,4,5)
			expect(rational.latexStringList.join(";").to_s).to eq "[]"
		end
		it "addFraction: should say '' when we check this method" do
			rational = RationalNumber.new()
			rational.addFraction(1,2,4,5)
			expect(rational.latexStringList.join(";").to_s).to eq "[]"
		end
		it "subtractFraction: should say '' when we check this method" do
			rational = RationalNumber.new()
			rational.subtractFraction(1,2,4,5)
			expect(rational.latexStringList.join(";").to_s).to eq "[]"
		end
		it "additiveInverse: should say '' when we check this method" do
			rational = RationalNumber.new()
			rational.additiveInverse(1,2)
			expect(rational.latexStringList.join(";").to_s).to eq "[]"
		end
		it "multiplicativeInverse: should say '' when we check this method" do
			rational = RationalNumber.new()
			rational.multiplicativeInverse(1,2)
			expect(rational.latexStringList.join(";").to_s).to eq "[]"
		end
		
	end
end