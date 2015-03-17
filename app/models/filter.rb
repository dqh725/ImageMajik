class Filter < ActiveRecord::Base

	 validates :FilterName, format: {with: /[a-zA-Z]+/, message: "only allows"}, presence: true
	  validates_uniqueness_of :FilterName
    
end
