Constants = {}

Constants["Class"] = AwesomeClass.new # Defining the 'Class' class

Constants["Class"].runtime_class = Constants["Class"] #Settinf the 'Class.class = Class'

Constants["Object"] = AwesomeClass.new

Constants["Number"] = AwesomeClass.new(Constants["Object"])

Constants["String"] = AwesomeClass.new

root_self = Constants["Object"].new
RootContext = Context.new(root_self)

Constants["TrueClass"] = AwesomeClass.new
Constants["FalseClass"] = AwesomeClass.new
Constants["NilClass"] = AwesomeClass.new

Constants["true"] = Constants["TrueClass"].new
Constants["false"] = Constants["FalseClass"].new
Constants["nil"] = Constants["NilClass"].new

Constants["Class"].def :new do |receiver, arguments|
	receiver.new
end

Constants["Object"].def :print do |receiver, arguments|
	puts arguments.first.ruby_value
	Constants["nil"] # Always returning objects from our runtime
end

Constants["Number"].def :+ do |receiver, arguments|
	result = receiver.ruby_value + arguments.first.ruby_value
	Constants["Number"].new_with_value(result)
end
