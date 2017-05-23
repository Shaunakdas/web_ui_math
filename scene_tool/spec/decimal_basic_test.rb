require_relative '../decimal_basic'
describe DecimalBasic do
	context "When testing the DecimalBasic class" do

		it "Initialize: should say '' when we check initialize method" do
			decObj = DecimalBasic.new()
			expect(decObj.latexStringList.to_s).to eq "[]"
		end
		it "decBas_fracToDecimal: should say '' when we check decBas_fracToDecimal method" do
			decObj = DecimalBasic.new()
			decObj.decBas_fracToDecimal(1,2)
			expect(decObj.latexStringList.join(";").to_s).to eq "\\frac{1}{2}=\\frac{1\\times5.0}{2\\times5.0}=\\frac{5.0}{10.0}=0.5"
		end
		it "decBas_decToFrac: should say '' when we check decBas_decToFrac method" do
			decObj = DecimalBasic.new()
			decObj.decBas_decToFrac(0.5)
			expect(decObj.latexStringList.join(";").to_s).to eq "0.5=0.0+\\frac{5}{10}=0.0+\\frac{1}{2};0.5=\\frac{1}{2}"
		end
		it "decBas_placeValueTableToDec: should say '' when we check decBas_placeValueTableToDec method" do
			decObj = DecimalBasic.new()
			decObj.decBas_placeValueTableToDec(1.5)
			expect(decObj.latexStringList.join(";").to_s).to eq "1.5=1\\times1+5\\times\\frac{1}{10};1.5=1+\\frac{5}{10}"
		end
		it "decBas_multipleBasic: should say '' when we check decBas_multipleBasic method" do
			decObj = DecimalBasic.new()
			decObj.decBas_multipleBasic(0.1,0.01)
			puts decObj.latexStringList.join(";").to_s
			expect(decObj.latexStringList.join(";").to_s).to eq "First we multiply them as whole numbers ignoring the decimal point;In 0.1\\times0.01, we found 1\\times1=1;The number of digits to be counted is obtained by adding the number of digits to the right of the decimal point in the decimal numbers that are being multiplied.;In 0.1\\times0.01, For placing the decimal in the product obtained, we count 1+2=3digits starting from the rightmost digit.;Thus, 0.1\\times0.01=0.001"
		end
		it "decBas_multipleTens: should say '' when we check decBas_multipleTens method" do
			decObj = DecimalBasic.new()
			decObj.decBas_multipleTens(0.1,10)
			expect(decObj.latexStringList.join(";").to_s).to eq "0.1\\times10=\\frac{1}{10}\\times10=1.0"
		end
		it "decBas_divisionWhole: should say '' when we check decBas_divisionWhole method" do
			decObj = DecimalBasic.new()
			decObj.decBas_divisionWhole(0.2,4)
			expect(decObj.latexStringList.join(";").to_s).to eq "0.2\\div4=\\frac{2}{10}\\times\\frac{1}{4};0.2\\div4=\\frac{1}{10}\\times\\frac{2}{4}=0.05"
		end
	end
end