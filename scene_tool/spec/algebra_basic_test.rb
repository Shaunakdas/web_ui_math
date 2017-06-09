require_relative '../algebra_basic'
describe AlgebraBasic do
	context "When testing the AlgebraBasic class" do

		it "Initialize: should say '' when we check initialize method" do
			algObj = AlgebraBasic.new()
			expect(algObj.latexStringList.to_s).to eq "[]"
		end
		it "intBas_getSignFromText: should say '' when we check intBas_getSignFromText method" do
			algObj = AlgebraBasic.new()
			algObj.intBas_getSignFromText("profit")
			expect(algObj.latexStringList.join(";").to_s).to eq "Since profit and loss are opposite situations and if profit is represented by ‘+’ sign,loss can be represented by ‘–’ sign"
		end
		it "algBas_parseTerm: should say '' when we check algBas_parseTerm method" do
			algObj = AlgebraBasic.new()
			algObj.algBas_parseTerm("5")
			expect(algObj.latexStringList.join(";").to_s).to eq ""
		end
		it "algBas_parseTerm: should say '' when we check algBas_parseTerm method" do
			algObj = AlgebraBasic.new()
			algObj.algBas_parseTerm("5x")
			expect(algObj.latexStringList.join(";").to_s).to eq "5x"
		end
		it "algBas_parseTerm: should say '' when we check algBas_parseTerm method" do
			algObj = AlgebraBasic.new()
			algObj.algBas_parseTerm("5^{2}")
			expect(algObj.latexStringList.join(";").to_s).to eq "5^{2}"
		end
		it "algBas_parseTerm: should say '' when we check algBas_parseTerm method" do
			algObj = AlgebraBasic.new()
			algObj.algBas_parseTerm("5x^{2}")
			expect(algObj.latexStringList.join(";").to_s).to eq "5x^{2}"
		end
		it "algBas_parseTerm: should say '' when we check algBas_parseTerm method" do
			algObj = AlgebraBasic.new()
			algObj.algBas_parseTerm("5^{3}x^{2}")
			expect(algObj.latexStringList.join(";").to_s).to eq "5^{3}x^{2}"
		end
		it "algBas_parseTerm: should say '' when we check algBas_parseTerm method" do
			algObj = AlgebraBasic.new()
			algObj.algBas_parseTerm("5xy")
			expect(algObj.latexStringList.join(";").to_s).to eq "5xy"
		end
		it "algBas_parseTerm: should say '' when we check algBas_parseTerm method" do
			algObj = AlgebraBasic.new()
			algObj.algBas_parseTerm("5^{4}x^{2}y^{3}")
			expect(algObj.latexStringList.join(";").to_s).to eq "5^{4}x^{2}y^{3}"
		end
		it "algBas_parseTerm: should say '' when we check algBas_parseTerm method" do
			algObj = AlgebraBasic.new()
			algObj.algBas_parseTerm("15xy")
			expect(algObj.latexStringList.join(";").to_s).to eq "15xy"
		end
		it "algBas_parseTerm: should say '' when we check algBas_parseTerm method" do
			algObj = AlgebraBasic.new()
			algObj.algBas_parseTerm("")
			expect(algObj.latexStringList.join(";").to_s).to eq ""
		end
		it "algBas_parseTerm: should say '' when we check algBas_parseTerm method" do
			algObj = AlgebraBasic.new()
			algObj.algBas_parseTerm("")
			expect(algObj.latexStringList.join(";").to_s).to eq ""
		end

	end
end