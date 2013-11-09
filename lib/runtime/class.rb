class AwesomeClass < AwesomeObject
	# classes are object in awesome so they inherit from AwesomeObject

	attr_reader :runtime_methods

	def initialize(superclass = nil)
		@runtime_methods = {}
		@runtime_class = Constants["Class"]
		@runtime_superclass = superclass
	end

	# lookup a method
	def lookup(method_name)
		method = @runtime_methods[method_name]
		unless method
			if @runtime_superclass
				return @runtime_superclass.lookup(method_name)
			else
				raise "Method not found: #{method_name}" if method.nil?
			end
		end
		method
	end

	# Helper method to define a method on this class from Ruby
	def def(name, &block)
		@runtime_methods[name.to_s] = block
	end

	# Create a new instance of this class
	def new
		AwesomeObject.new(self)
	end

	# Create an instance of this AwesomeClass that holds a Ruby value.
	# Like a String, Number or true
	def new_with_value(value)
		AwesomeObject.new(self, value)
	end


end # end of the AwesomeClass