class Variable
	attr_accessor :symbol,:substituteValue,:substituteNegative
	
	def initialize(symbol)
		@symbol = symbol
	end
	def toLatexString
		@symbol.to_s
	end
	def setValue(value)
		@substituteValue = value
		@substituteNegative = false
		@substituteNegative = true if value < 0
	end
	def equals(other)
		if (defined?(@substituteValue)).nil?
			return (@substituteValue == other.substituteValue);
		else
			return (@symbol == other.symbol);
		end
	end
end

describe Variable do
	context "When testing the Variable class" do

		it "should say 'Hello World' when we call the say_hello method " do
			var = Variable.new("x")
			latexString = var.toLatexString()
			expect(latexString).to eq "x"
		end
	end
end