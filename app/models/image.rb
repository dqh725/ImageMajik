require 'mini_magick'
class Image < ActiveRecord::Base
	belongs_to :user
	belongs_to :gallery
	mount_uploader :picture, PictureUploader
	validates :picture, presence: true

	has_many :sharedImages, :dependent => :destroy
	has_many :users, through: :sharedImages

	accepts_nested_attributes_for :sharedImages,allow_destroy: true
	
	

	# def add_filter
	# 	self.picture_url(:blur)		
	# 	#pic.contrast(filter.constrast)
	# end

	def getPath original,filter
		out = File.join(File.dirname(original),"filter#{filter}.png")
		if filter==:blue_shift		
			blue_shift(original,out)
		
		elsif filter == :blur
			blur(original,out)
		
		elsif filter == :brightness
			brightness(original,out)

		elsif filter == :colorspace
			colorspace(original,out)	
		elsif filter ==:hue
			hue(original,out)
		end
		out
		
	end

	def hue original,out, hue = 80
		im = MiniMagick::Image.open(File.join(Rails.root,'public/', original))
		im.combine_options do |c|
			 c.modulate hue= hue
		end
		im.write(File.join(Rails.root,'public',out))
		
	end

	# def filter1 out, blue_shift = 2
	# 	im = MiniMagick::Image.open(File.join(Rails.root,'public', self.picture_url))
	# 	im.combine_options do |c|
	# 		 c.channel "Red"
	# 		 c.blue_shift blue_shift	
	# 	end
	# 	im.write(File.join(Rails.root,'public',out))
	# end

	def blur original, out, blur=100

		im = MiniMagick::Image.open(File.join(Rails.root,'public', original))
		im.combine_options do |c|
			 c.blur blur	
		end
		im.write(File.join(Rails.root,'public',out))
	end

	def brightness original,out, brightness=50

		im = MiniMagick::Image.open(File.join(Rails.root,'public', original))
		im.combine_options do |c|
			 # c.channel "Red"
			 c.brightness_contrast brightness	
		end
		im.write(File.join(Rails.root,'public',out))
	end

	def colorspace original,out, color = "Gray"

		im = MiniMagick::Image.open(File.join(Rails.root,'public', original))
		im.combine_options do |c|
			 # c.channel "Red"
			 c.colorspace color	
		end
		im.write(File.join(Rails.root,'public',out))
	end



end
