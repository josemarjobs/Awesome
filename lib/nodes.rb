class Nodes < Struct.new(:nodes)

	def << (node)
		nodes << node
		self
	end
end

class LiteralNode < Struct.new(:value); end
class NumberNode < LiteralNode; end
class StringNode < LiteralNode; end

class TrueNode < LiteralNode
	def initialize
		super(true)
	end
end	
class FalseNode < LiteralNode
	def initialize
		super(false)
	end
end	
class NilNode < LiteralNode
	def initialize
		super(nil)
	end
end	

class CallNode < Struct.new(:receiver, :method, :arguments); end

class GetConstantNode < Struct.new(:name); end

# Sets the value of a constant, the value is a node
class SetConstantNode < Struct.new(:name, :value); end

# the following is for dealing with local variables
class GetLocalNode < Struct.new(:name); end
class SetLocalNode < Struct.new(:name); end

# method definition, the body is a tree of nodes
class DefNode < Struct.new(:name, :params, :body); end

# class definition, the name and the body are tree of nodes
class ClassNode < Struct.new(:name, :body); end

# control structures, the body is a tree of nodes
class IfNode < Struct.new(:condition, :body); end
class WhileNode < Struct.new(:condition, :body); end













