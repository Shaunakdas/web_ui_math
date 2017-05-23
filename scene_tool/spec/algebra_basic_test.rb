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
	end
end