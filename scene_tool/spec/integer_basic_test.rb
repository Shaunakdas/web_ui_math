require_relative '../integer_basic'
describe IntegerBasic do
	context "When testing the IntegerBasic class" do

		it "Initialize: should say '' when we check initialize method" do
			intObj = IntegerBasic.new()
			expect(intObj.latexStringList.to_s).to eq "[]"
		end
		it "intBas_getSignFromText: should say '' when we check intBas_getSignFromText method" do
			intObj = IntegerBasic.new()
			intObj.intBas_getSignFromText("profit")
			expect(intObj.latexStringList.join(";").to_s).to eq "Since profit and loss are opposite situations and if profit is represented by ‘+’ sign,loss can be represented by ‘–’ sign"
		end
		it "intBas_positionOnNumberLine: should say '' when we check intBas_getSignFromText method" do
			intObj = IntegerBasic.new()
			intObj.intBas_positionOnNumberLine(2,4)
			expect(intObj.latexStringList.join(";").to_s).to eq "As we know that 2<4, 2 will be on the left side of 4. And hence 4 will be on right of 2."
		end
		it "intBas_compare: should say '' when we check intBas_compare method" do
			intObj = IntegerBasic.new()
			intObj.intBas_compare(2,-3)
			puts intObj.latexStringList.join(";").to_s
			expect(intObj.latexStringList.join(";").to_s).to eq "We know that on a number line the number increases as we move to the right and decreases as we move to the left;As we know that -3<0, -3 is on the left of 0;And we know that 2>0, 2 is on the right of 0;Therefore -3 < 0 < 2, and hence -3 < 2"
		end
		it "intBas_add: should say '' when we check intBas_add method" do
			intObj = IntegerBasic.new()
			intObj.intBas_add(-4,3)
			expect(intObj.latexStringList.join(";").to_s).to eq "1+(-3)+3;1+0;1"
		end
		it "intBas_subtract: should say '' when we check intBas_subtract method" do
			intObj = IntegerBasic.new()
			intObj.intBas_subtract(2,-5)
			expect(intObj.latexStringList.join(";").to_s).to eq "To subtract an integer from another integer it is enough to add the additive inverse of the integer that is being subtracted, to the other integer.;2-(-5);2+Additive Inverse of -5;2+5;7"
		end
		it "intBas_multiple: should say '' when we check intBas_multiple method" do
			intObj = IntegerBasic.new()
			intObj.intBas_multiple(2,-5)
			expect(intObj.latexStringList.join(";").to_s).to eq "While multiplying a positive integer and a negative integer, we multiply them as whole numbers and put a minus sign (–) before the product;2\\times(-5)=-(2\\times5)=-10"
		end
		it "intBas_divide: should say '' when we check intBas_divide method" do
			intObj = IntegerBasic.new()
			intObj.intBas_divide(10,-5)
			expect(intObj.latexStringList.join(";").to_s).to eq "when we divide a positive integer by a negative integer, we first divide them as whole numbers and then put a minus sign (–) before the quotient.;10\\div(-5)=-(10\\div5)=-2.0"
		end
	end
end