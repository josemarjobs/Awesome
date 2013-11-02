class Lexer
		KEYWORDS = ["def", "class", "if", "true", "false", "nil"]

		def tokenize(code)
			code.chomp! # Remove extra line breaks
			tokens = [] # this will hold the generated tokens

			current_indent = 0
			indent_stack = []
			i = 0 # Current character position
			while i < code.size
				chunk = code[i..-1]

				# match name(method name, variable names etc)
				if identifier = chunk[/\A([a-z]\w*)/, 1]
					if KEYWORDS.include?(identifier) #keywords will generate [:IF, "if"]
						tokens << [identifier.upcase.to_sym, identifier]
					else
						tokens << [:IDENTIFIER, identifier]
					end
					i += identifier.size # skip what we just parsed

				# match constants(capital letters)	
				elsif constant = chunk[/\A([A-Z]\w*)/, 1]
					tokens << [:CONSTANT, constant]
					i += constant.size

				# match numbers
				elsif number = chunk[/\A([0-9]+)/, 1]
					tokens << [:NUMBER, number.to_i]
					i += number.size

				# match strings, anything between "..."
				elsif string = chunk[/\A"([^"]*)"/, 1]
					tokens << [:STRING, string]
					i += string.size + 2 # skip two more to exclude the '"'

				# match :<newline><spaces>
				elsif indent = chunk[/\A\:\n( +)/m, 1]
					if indent.size <= current_indent # indent should go up when creating a block
						raise "Bad indent level, got #{indent.size} indents, "+
									"expected > #{current_indent}"
					end
					current_indent = indent.size
					indent_stack.push(current_indent)
					tokens << [:INDENT, indent.size]
					i += indent.size + 2

				elsif indent = chunk[/\A\n( *)/m, 1] # matches <newline> <spaces>
					if indent.size == current_indent # Case 2
						tokens << [:NEWLINE, "\n"] # nothing to do, we are still in the same block
					elsif indent.size < current_indent # Case 3
						while indent.size < current_indent	
							indent_stack.pop
							current_indent = indent_stack.last || 0
							tokens << [:DEDENT, indent.size]
						end
						tokens << [:NEWLINE, "\n"]
					else #indent.size > current_indent, error!
						raise "Missing ':'" #Cannot increase indent level without using ":"
					end
					i += indent.size + 1
				
				elsif operator = chunk[/\A(\|\||&&|==|!=|<=|>=)/, 1]
					tokens << [operator, operator]
					i += operator.size

				elsif chunk.match(/\A /)
					i += 1

				else
					value = chunk[0,1]
					tokens << [value, value]
					i += 1
				end

			end

			# close all open blocks
			while indent = indent_stack.pop
				tokens << [:DEDENT, indent_stack.first || 0]
			end

			tokens
		end

end