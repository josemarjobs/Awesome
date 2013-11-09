require "spec_helper"
require "runtime"

describe "Object.new" do

	before do 
		@object = Constants["Object"].call("new")
	end

	it "should mimic object.new in the language" do
		expect(Constants["Object"]).to eq @object.runtime_class
	end
end

describe "AwesomeClass" do
	it "should be kind of class" do
		expect(Constants["Class"]).to eq Constants["Number"].runtime_class
	end
end

describe "x+2" do
	it "should add two numbers" do
		expect(Constants["Number"].new_with_value(2).ruby_value + 2).to eq Constants["Number"].new_with_value(4).ruby_value
	end
end
