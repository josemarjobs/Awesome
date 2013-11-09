require("spec_helper")
require "parser"

describe Parser do
	before do
@code = <<-CODE
def method(a, b):
  true
CODE
@nodes = Nodes.new([
	DefNode.new("method", ["a", "b"],
		Nodes.new([TrueNode.new])
	)
])
	end
	it "parses method definition correctly" do
		@nodes.should == Parser.new.parse(@code)
	end
end