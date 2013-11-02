require_relative "spec_helper"

describe Lexer do
	before do
@code = <<-CODE
if 1:
  if 2:
    print("...")
    if false:
      pass
    print("done!")
  2

print "The End"
CODE
@tokens = [
   [:IF, "if"], [:NUMBER, 1],                            # if 1:
     [:INDENT, 2],
       [:IF, "if"], [:NUMBER, 2],                        #   if 2:
       [:INDENT, 4],
         [:IDENTIFIER, "print"], ["(", "("],             #     print("...")
                                   [:STRING, "..."],
                                 [")", ")"],
                                 [:NEWLINE, "\n"],       
         [:IF, "if"], [:FALSE, "false"],                 #     if false:
         [:INDENT, 6],
           [:IDENTIFIER, "pass"],                        #       pass
         [:DEDENT, 4], [:NEWLINE, "\n"],
         [:IDENTIFIER, "print"], ["(", "("],             #     print("done!")
                                   [:STRING, "done!"],
                                 [")", ")"], 
[:DEDENT, 2], [:NEWLINE, "\n"],
        [:NUMBER, 2],                                       #   2
      [:DEDENT, 0], [:NEWLINE, "\n"],
      [:NEWLINE, "\n"],                                     # 
      [:IDENTIFIER, "print"], [:STRING, "The End"]          # print "The End"
    ]

	end
	it "is true" do
		@tokens.should == Lexer.new.tokenize(@code)
	end	

	it "should parse if correctly" do
		[[:IF, "if"]].should == Lexer.new.tokenize("if")
	end		
	it "should parse def correctly" do
		[[:DEF, "def"]].should == Lexer.new.tokenize("def")
	end		
	it "should parse nome(IDENTIFIER) correctly" do
		[[:IDENTIFIER, "nome"]].should == Lexer.new.tokenize("nome")
	end		
	it "should parse print correctly" do
		[
			[:IDENTIFIER, "print"], 
			["(", "("], 
			[:STRING, "josemar"], 
			[")", ")"], 
		].should == Lexer.new.tokenize('print("josemar")')
	end	
end