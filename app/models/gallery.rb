class Gallery < ActiveRecord::Base
	has_many:images

	validates :name, format: {with: /[a-zA-Z]+/, messgae: "only allows letters"}, presence: true
	validates_uniqueness_of :name

	def getImg id
		
		@images = Image.where(gallery_id:self.id, inTrash:false,user_id:id)
	end
end
