require_relative '../number_system'
describe NumberSystem do
	context "When testing the NumberSystem class" do

		it "Initialize: should say '' when we check initialize method" do
			numObj = NumberSystem.new()
			expect(numObj.latexStringList.to_s).to eq "[]"
		end
		it "numSys_factor: should say '' when we check numSys_factor method" do
			numObj = NumberSystem.new()
			numObj.numSys_factor(24)
			expect(numObj.latexStringList.join(";").to_s).to eq "24=1\\times24;24=2\\times12;24=3\\times8;24=4\\times6;Thus the factors are 1,2,3,4,6,8,12,24"
		end
		it "numSys_primeFactor: should say '' when we check this method" do
			numObj = NumberSystem.new()
			numObj.numSys_primeFactor(24)
			expect(numObj.latexStringList.join(";").to_s).to eq "24=2x12;24=2x2x6;24=2x2x2x3"
		end
		it "numSys_hcf: should say '' when we check this method" do
			numObj = NumberSystem.new()
			numObj.numSys_hcf(24,12)
			expect(numObj.latexStringList.join(";").to_s).to eq "24=2X2X2X3;12=2X2X3;Clearly Common factors are 2,2,3;2 comes minimum of 2 times;3 comes minimum of 1 times;2X2X3X1 = 12"
		end
		it "numSys_lcm: should say '' when we check this method" do
			numObj = NumberSystem.new()
			numObj.numSys_lcm(24,12)
			expect(numObj.latexStringList.join(";").to_s).to eq "24=2X2X2X3;12=2X2X3;Clearly Common factors are 2,2,3;2 comes maximum of 3 times;3 comes maximum of 1 times;2X3X3X1 = 24"
		end
		it "numSys_rearrangeDigit: should say '' when we check this method" do
			numObj = NumberSystem.new()
			numObj.numSys_rearrangeDigit(1,2,5,3,2)
			# puts numObj.latexStringList.join(";").to_s
			expect(numObj.latexStringList.join(";").to_s).to eq "We have to create greatest and smallest number by rearranging 1,2,5,3,2;Above List can be rearranged in increasing order as 1,2,2,3,5;Hence the smallest number possible will be 12235;And the same List can be rearranged in decreasing order as 5,3,2,2,1;Hence the greatest number possible will be 53221"
		end
		it "numSys_rearrangeDigit: should say '' when we check this method" do
			numObj = NumberSystem.new()
			numObj.numSys_rearrangeDigit(10245)
			# puts numObj.latexStringList.join(";").to_s
			expect(numObj.latexStringList.join(";").to_s).to eq "Digits present in 10245 are 1,0,2,4,5;We have to create greatest and smallest number by rearranging 1,0,2,4,5;Above List can be rearranged in increasing order as 0,1,2,4,5;Hence the smallest number possible will be 1245;And the same List can be rearranged in decreasing order as 5,4,2,1,0;Hence the greatest number possible will be 54210"
		end
		it "numSys_roundOff: should say '' when we check this method" do
			numObj = NumberSystem.new()
			numObj.numSys_roundOff(889,100)
			# puts numObj.latexStringList.join(";").to_s
			expect(numObj.latexStringList.join(";").to_s).to eq "889 lies between 900 and 800.;It is nearer to 900, so it is rounded off as 900"
		end
		it "numSys_sumEstimate: should say '' when we check this method" do
			numObj = NumberSystem.new()
			numObj.numSys_sumEstimate(889,78)
			# puts numObj.latexStringList.join(";").to_s
			expect(numObj.latexStringList.join(";").to_s).to eq "Approximating to nearest hundreds, 889 rounds off to 900;Approximating to nearest tens, 78 rounds off to 80;Adding 3th column i.e. 8,0;Adding 2th column i.e. 0,0;Adding 1th column i.e. 0,"
		end
		it "numSys_nearby: should say '' when we check this method" do
			numObj = NumberSystem.new()
			numObj.numSys_nearby(12)
			# puts numObj.latexStringList.join(";").to_s
			expect(numObj.latexStringList.join(";").to_s).to eq "To get a successor of any natural number, you can add 1 to that number. Hence Successor of 12 is 13;To get a predecessor of any natural number, you can subtract 1 from that number. Hence Predecessor of 12 is 11"
		end
		it "numSys_multiple: should say '' when we check this method" do
			numObj = NumberSystem.new()
			numObj.numSys_multiple(20,4)
			# puts numObj.latexStringList.join(";").to_s
			expect(numObj.latexStringList.join(";").to_s).to eq "The required multiples are;20\\times1=20,20\\times2=40,20\\times3=60,20\\times4=80;20,40,60,80"
		end
		it "numSys_convertToRoman: should say '' when we check this method" do
			numObj = NumberSystem.new()
			numObj.numSys_convertToRoman(204)
			# puts numObj.latexStringList.join(";").to_s
			expect(numObj.latexStringList.join(";").to_s).to eq "204 = (100+100)+(4) ;204 = (C+C)+(IV) ;Roman form of 204 is CCIV"
		end
		it "numSys_primeInRange: should say '' when we check this method" do
			numObj = NumberSystem.new()
			numObj.numSys_primeInRange(4,20)
			# puts numObj.latexStringList.join(";").to_s
			expect(numObj.latexStringList.join(";").to_s).to eq "Primes between 4 and 20 are 5,7,11,13,17,19"
		end
		it "numSys_divisibilityTest: should say '' when we check this method" do
			numObj = NumberSystem.new()
			numObj.numSys_divisibilityTest(24,10)
			# puts numObj.latexStringList.join(";").to_s
			expect(numObj.latexStringList.join(";").to_s).to eq "if a number has 0 in the ones place then it is divisible by 10.;Ones digit of 24 is 4;Hence 24 is not divisible by 10"
		end
		it "numSys_divisibilityTest: should say '' when we check this method" do
			numObj = NumberSystem.new()
			numObj.numSys_divisibilityTest(24,5)
			# puts numObj.latexStringList.join(";").to_s
			expect(numObj.latexStringList.join(";").to_s).to eq "a number which has either 0 or 5 in its ones place is divisible by 5;Ones digit of 24 is 4;Hence 24 is not divisible by 5"
		end
		it "numSys_divisibilityTest: should say '' when we check this method" do
			numObj = NumberSystem.new()
			numObj.numSys_divisibilityTest(24,2)
			# puts numObj.latexStringList.join(";").to_s
			expect(numObj.latexStringList.join(";").to_s).to eq "a number is divisible by 2 if it has any of the digits 0, 2, 4, 6 or 8 in its ones place.;Ones digit of 24 is 4;Hence 24 is divisible by 2"
		end
		it "numSys_divisibilityTest: should say '' when we check this method" do
			numObj = NumberSystem.new()
			numObj.numSys_divisibilityTest(24,3)
			# puts numObj.latexStringList.join(";").to_s
			expect(numObj.latexStringList.join(";").to_s).to eq "if the sum of the digits is a multiple of 3, then the number is divisible by 3.;sum of digits of 24 is 6;Hence 24 is divisible by 3"
		end
		it "numSys_divisibilityTest: should say '' when we check this method" do
			numObj = NumberSystem.new()
			numObj.numSys_divisibilityTest(24,6)
			# puts numObj.latexStringList.join(";").to_s
			expect(numObj.latexStringList.join(";").to_s).to eq "if a number is divisible by 2 and 3 both then it is divisible by 6 also.;a number is divisible by 2 if it has any of the digits 0, 2, 4, 6 or 8 in its ones place.;Ones digit of 24 is 4;Hence 24 is divisible by 2;if the sum of the digits is a multiple of 3, then the number is divisible by 3.;sum of digits of 24 is 6;Hence 24 is divisible by 3;Hence 24 is divisible by 6"
		end
		it "numSys_divisibilityTest: should say '' when we check this method" do
			numObj = NumberSystem.new()
			numObj.numSys_divisibilityTest(1024,4)
			# puts numObj.latexStringList.join(";").to_s
			expect(numObj.latexStringList.join(";").to_s).to eq "a number with 3 or more digits is divisible by 4 if the number formed by its last two digits (i.e. ones and tens) is divisible by 4.;number formed by its last two digits is 24;Hence 1024 is divisible by 4"
		end
		it "numSys_divisibilityTest: should say '' when we check this method" do
			numObj = NumberSystem.new()
			numObj.numSys_divisibilityTest(1124,8)
			# puts numObj.latexStringList.join(";").to_s
			expect(numObj.latexStringList.join(";").to_s).to eq "a number with 4 or more digits is divisible by 8, if the number formed by the last three digits is divisible by 8.;number formed by its last three digits is 124;Hence 1124 is not divisible by 8"
		end
		it "numSys_divisibilityTest: should say '' when we check this method" do
			numObj = NumberSystem.new()
			numObj.numSys_divisibilityTest(24,9)
			# puts numObj.latexStringList.join(";").to_s
			expect(numObj.latexStringList.join(";").to_s).to eq "if the sum of the digits of a number is divisible by 9, then the number itself is divisible by 9.;sum of digits of 24 is 6;Hence 24 is not divisible by 9"
		end
		it "numSys_divisibilityTest: should say '' when we check this method" do
			numObj = NumberSystem.new()
			numObj.numSys_divisibilityTest(24,11)
			# puts numObj.latexStringList.join(";").to_s
			expect(numObj.latexStringList.join(";").to_s).to eq "find the difference between the sum of the digits at odd places (from the right) and the sum of the digits at even places (from the right) of the number. If the difference is either 0 or divisible by 11, then the number is divisible by 11.;sum of the digits at odd places is 4 and sum of the digits at even places is 0;Hence 24 is not divisible by 11"
		end
		it "numSys_commonFactorList: should say '' when we check this method" do
			numObj = NumberSystem.new()
			numObj.numSys_commonFactorList(24,12,6)
			# puts numObj.latexStringList.join(";").to_s
			expect(numObj.latexStringList.join(";").to_s).to eq "24=2X2X2X3;12=2X2X3;6=2X3;Clearly Common prime factors are 2,3"
		end
		it "numSys_commonMultipleList: should say '' when we check this method" do
			numObj = NumberSystem.new()
			numObj.numSys_commonMultipleList(24,12,6)
			# puts numObj.latexStringList.join(";").to_s
			expect(numObj.latexStringList.join(";").to_s).to eq "24=2X2X2X3;12=2X2X3;6=2X3;Common multiples of this list are 24,48 and 72"
		end
		it "numSys_indianSystemExpansion: should say '' when we check this method" do
			numObj = NumberSystem.new()
			numObj.numSys_indianSystemExpansion(17628289)
			puts numObj.latexStringList.join(";").to_s
			expect(numObj.latexStringList.join(";").to_s).to eq "After adding comma at the right places according to indian numbering system, 17628289 = 1,76,28,289;Indian form of numeration for 17628289 is one crore seventy six lakh twenty eight thousand two hundred eighty nine"
		end
		it "numSys_internationalSystemExpansion: should say '' when we check this method" do
			numObj = NumberSystem.new()
			numObj.numSys_internationalSystemExpansion(17628289)
			puts numObj.latexStringList.join(";").to_s
			expect(numObj.latexStringList.join(";").to_s).to eq "After adding comma at the right places according to indian numbering system, 17628289 = 17,628,289;Indian form of numeration for 17628289 is seventeen million, six hundred and twenty-eight thousand, two hundred and eighty-nine"
		end
	end
end