class Operation < ActiveRecord::Base
	serialize :data
	#accepts_nested_attributes_for :data, :allow_destroy => true
end
