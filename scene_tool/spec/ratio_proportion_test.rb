require_relative '../ratio_proportion'
describe RatioProportion do
	context "When testing the Ratio Proportion class" do

		it "Initialize: should say '' when we check initialize method" do
			ratio = RatioProportion.new()
			expect(ratio.latexStringList.to_s).to eq "[]"
		end
		it "simpleRatio: should say '' when we check method" do
			ratio = RatioProportion.new()
			ratio.ratPro_simpleRatio(2,4,"km")
			expect(ratio.latexStringList.join(";").to_s).to eq "Required ratio is 2 unit : 4 unit;= \\frac{2}{4};\\frac{2}{4}=\\frac{2\\div2}{4\\div2}=\\frac{1}{2};Required Ratio is 1 : 2"
		end
		it "equivalentRatio: should say '' when we check method" do
			ratio = RatioProportion.new()
			ratio.ratPro_equivalentRatio(2,3,4,false)
			puts ratio.latexStringList.join(";").to_s
			expect(ratio.latexStringList.join(";").to_s).to eq "Required ratio is 2 : 3;= \\frac{2}{3};We know 2\\times2=4;This means we need to multiply both the numerator and denominator by 2to get the equivalent fraction;Hence ;\\frac{2}{3}=\\frac{2\\times2}{3\\times2};\\frac{2}{3}=\\frac{4}{6};\\frac{4}{6} is required equivalent fraction;Required Ratio is 4:6"
		end
		it "checkProportion: should say '' when we check method" do
			ratio = RatioProportion.new()
			ratio.ratPro_checkProportion(2,3,6,9)
			puts ratio.latexStringList.join(";").to_s
			expect(ratio.latexStringList.join(";").to_s).to eq "Ratio of 2 to 3;\\frac{2}{3}=\\frac{2\\div1}{3\\div1}=\\frac{2}{3};Ratio of 6 to 9;\\frac{6}{9}=\\frac{6\\div3}{9\\div3}=\\frac{2}{3};Since both the ratios are same;Hence2:3 = 6:9;Therefore 2, 3, 6 and 9 are in proportion"
		end
		it "unitaryMethod: should say '' when we check method" do
			ratio = RatioProportion.new()
			ratio.ratPro_unitaryMethod(2,4,8,"first","second")
			expect(ratio.latexStringList.join(";").to_s).to eq "first2second4;first1second2;first1second2\\times8=16;first1second16"
		end
		it "checkEquivalence: should say '' when we check method" do
			ratio = RatioProportion.new()
			ratio.ratPro_checkEquivalence(2,4,6,12)
			puts ratio.latexStringList.join(";").to_s
			expect(ratio.latexStringList.join(";").to_s).to eq "Ratio of 2 to 4;\\frac{2}{4}=\\frac{2\\div2}{4\\div2}=\\frac{1}{2};Ratio of 6 to 12;\\frac{6}{12}=\\frac{6\\div6}{12\\div6}=\\frac{1}{2};Since both the ratios are same;Hence2:4 = 6:12;Therefore 2:4 and 6:12 are in equivalence"
		end
		it "fractionToPercentage: should say '' when we check method" do
			ratio = RatioProportion.new()
			ratio.ratPro_fractionToPercentage(2,4)
			expect(ratio.latexStringList.join(";").to_s).to eq "\\frac{2}{4}\\frac{100}{100}=\\frac{50.0}{100}= 50.0(out of hundred);50.0\\%"
		end
		it "decimalToPercentage: should say '' when we check method" do
			ratio = RatioProportion.new()
			ratio.ratPro_decimalToPercentage(0.12)
			expect(ratio.latexStringList.join(";").to_s).to eq "0.12=0.12\\times100\\%;0.12=\\frac{12.0}{100}\\times100\\%;0.12=12.0\\%"
		end
		it "ratioToPercentage: should say '' when we check method" do
			ratio = RatioProportion.new()
			ratio.ratPro_ratioToPercentage(2,4)
			expect(ratio.latexStringList.join(";").to_s).to eq " Total part is 6; First percentage is \\frac{2}{2+4}\\times100\\%=33.33;First percentage is \\frac{4}{2+4}\\times100\\%=66.67"
		end
		it "calcProfitPercent: should say '' when we check method" do
			ratio = RatioProportion.new()
			ratio.ratPro_calcProfitPercent(50,100)
			expect(ratio.latexStringList.join(";").to_s).to eq " Profit percent is = \\frac{Profit}{Cost} \\times 100 \\frac{50}{100}\\times100=50.0\\%"
		end
		it "calcProfit: should say '' when we check method" do
			ratio = RatioProportion.new()
			ratio.ratPro_calcProfit(40,200)
			expect(ratio.latexStringList.join(";").to_s).to eq " Profit = Profit \\% \\times Cost Price ;\\frac{40}{100}\\times200=80.0; Selling Price = Cost Price + Profit ; Selling Price = 200 + 80.0; Selling Price = 280.0"
		end
		it "calcLossPercent: should say '' when we check method" do
			ratio = RatioProportion.new()
			ratio.ratPro_calcLossPercent(50,100)
			expect(ratio.latexStringList.join(";").to_s).to eq " Loss percent is = \\frac{Loss}{Cost} \\times 100 \\frac{50}{100}\\times100=50.0\\%"
		end
		it "calcLoss: should say '' when we check method" do
			ratio = RatioProportion.new()
			ratio.ratPro_calcLoss(40,200)
			expect(ratio.latexStringList.join(";").to_s).to eq " Loss = Loss \\% \\times Cost Price ;\\frac{40}{100}\\times200=80.0; Selling Price = Cost Price - Loss ; Selling Price = 200 - 80.0; Selling Price = 120.0"
		end
		it "calcSimpleInterest: should say '' when we check method" do
			ratio = RatioProportion.new()
			ratio.ratPro_calcSimpleInterest(200,2,2)
			puts ratio.latexStringList.join(";").to_s
			expect(ratio.latexStringList.join(";").to_s).to eq " The sum borrowed = 200; Rate of interest = 2\\% per year; The interest to paid after 1 year = =\\frac{15}{100}\\times200=4.0; The interest to paid after 2 years = 8.0\\times2=8.0; The total amount to be paid after T years = A = P + I; Hence the total amount to be paid after 2 years = 200+8.0=208.0"
		end
		it "calcIncreaseFromPercent: should say '' when we check method" do
			ratio = RatioProportion.new()
			ratio.ratPro_calcIncreaseFromPercent(20,100)
			expect(ratio.latexStringList.join(";").to_s).to eq "20\\% of 100 =  \\frac{20}{100}\\times100=20.0;New Price = Old Price + Increase;New Price = 100 + 20.0 = 120.0"
		end
		it "calcDecreaseFromPercent: should say '' when we check method" do
			ratio = RatioProportion.new()
			ratio.ratPro_calcDecreaseFromPercent(20,100)
			expect(ratio.latexStringList.join(";").to_s).to eq "20\\% of 100 =  \\frac{20}{100}\\times100=20.0;New Price = Old Price - Decrease;New Price = 100 - 20.0 = 80.0"
		end
		it "calcDiscountPercent: should say '' when we check method" do
			ratio = RatioProportion.new()
			ratio.ratPro_calcDiscountPercent(120,80)
			expect(ratio.latexStringList.join(";").to_s).to eq "Discount =  Marked Price - Sales Price;New Price = 120 - 80 = 40;Discount Percentage =  \\frac{Discount}{Marked Price};Discount Percentage =  \\frac{40}{120}\\times100=33.33\\%"
		end
		it "calcSalesTax: should say '' when we check method" do
			ratio = RatioProportion.new()
			ratio.ratPro_calcSalesTax(120,40)
			expect(ratio.latexStringList.join(";").to_s).to eq "On 120, sales tax paid would be = \\frac{40}{100}\\times120=48.0;Bill amount = Cost of item + Sales tax = 120 + 48.0 = 168.0"
		end
		it "calcVAT: should say '' when we check method" do
			ratio = RatioProportion.new()
			ratio.ratPro_calcVAT(120,20)
			puts ratio.latexStringList.join(";").to_s
			expect(ratio.latexStringList.join(";").to_s).to eq "The price includes the VAT, i.e., the value added tax. Thus, a 20\\% VAT means if the price without VAT is 100 then price including VAT is 120. ;Now, when price including VAT is 120, original price is  100.;Hence when price including tax is 120, the original price \\frac{20}{120}\\times120=100.0"
		end
		it "calcCompoundInterest: should say '' when we check method" do
			ratio = RatioProportion.new()
			ratio.ratPro_calcCompoundInterest(100,4,4)
			puts ratio.latexStringList.join(";").to_s
			expect(ratio.latexStringList.join(";").to_s).to eq "We have, A = P{(1 + \\frac{R}{100})}^{n} ;where Principal(P)=100, Rate(R)=4,Number of years(n) = 4;=100{(1+\\frac{4}{100})}^{4};=100{(\\frac{104}{100})}^{4};= {(100\\times\\frac{104}{100}\\times\\frac{104}{100}\\times\\frac{104}{100}\\times\\frac{104}{100}=117.0)}^{4};CI = A - P =117.0 - 100 = 17.0"
		end

	end
end