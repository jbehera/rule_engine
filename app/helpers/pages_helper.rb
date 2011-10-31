module PagesHelper

	#Helper class 
	class Rule
		attr_accessor :category_id, :given_for, :given_operator, :given_value, 
					  :then_for, :then_operator, :then_value 
		def initialize(attributes = {})
			@category_id = attributes[:category_id]
			@given_for = attributes[:given_for]
			@given_operator = attributes[:given_operator]
			@given_value = attributes[:given_value]

			@then_for = attributes[:then_for]
			@then_operator = attributes[:then_operator]
			@then_value = attributes[:then_value]
		end
	end

	
end
