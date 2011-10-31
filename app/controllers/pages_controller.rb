class PagesController < ApplicationController

  def index
  		
  	rule = {
  				:category_id => 1,
	  			:given_for => %w{products.name products.category_id 
	  							products.price products.tax_percent products.discontinued},
			    :given_operator => {
				    					"equal" => "=", 
				    					"less than" => "<", 
				    					"greater than" => ">",
				    					"less than or equal" => "<=",
				    					"greater than or equal" => ">="
				    				},
				:give_value => "",

				#:then_for => %w{products.price products.tax_percent},

				:then_for => {:price => "products.price", :tax_percent => "products.tax_percent"},
				:then_operator => {"plus" => "+", "minus" => "-", "multiply" => "*", "devide" => "/"},
				:then_value => ""							
	  		}
  	
	  		
    @rule  = PagesHelper::Rule.new(rule)
  end

  def result

  	if(params[:rule])

  		filter_rule = params[:rule][:given_for].to_s << " " << params[:rule][:given_operator] 

  		@qry_result = Product.where("products.category_id = ? AND #{filter_rule} ?", 
  						params[:rule][:category_id], params[:rule][:given_value])


  		then_op = params[:rule][:then_operator]
  		then_val = params[:rule][:then_value]
  		

  		@qry_result.each do |row|

  			if ( !then_val.blank? &&  then_val != 0 )

	  			then_for = params[:rule][:then_for]
	  			then_for_val = eval ("row[:#{params[:rule][:then_for]}]")

	  			begin
		  			then_val_final = eval ("#{then_for_val} #{then_op} #{then_val}")	  			

		  			data = {then_for.to_sym => then_val_final}	  			
		  			row.update_attributes(data)
		  		rescue
		  			flash.now[:error] = "Incorrect field value"
	  			end

	  		else
	  			flash.now[:error] = "Incorrect value for 'Then field'"
  			end
  		end
  		
  	end

  end

end