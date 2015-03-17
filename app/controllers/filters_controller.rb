
class FiltersController < ApplicationController
	
	before_action :set_image, only: [:apply,:addTo]
	before_action :set_filter, only: [:index,:edit,:destroy]
	def new
		@filter = Filter.new
	end

	def editimage
		@gallery_id = params[:gallery_id]
		@image = Image.find(params[:image_id])
		@path=[]
		@path.push([@image.getPath(@image.picture_url,:blur),:blur])
		@path.push([@image.getPath(@image.picture_url,:brightness),:brightness])
		@path.push([@image.getPath(@image.picture_url,:hue),:hue])
		@path.push([@image.getPath(@image.picture_url,:colorspace),:colorspace])

	end

	def index

	end

	def show
		@filters = Filter.all
	end

	def destroy

		@filter.destroy
    	respond_to do |format|
      	format.html { 
      		@filters = Filter.all
      		render :show, notice: 'Image was successfully destroyed.' }
      	format.json { head :no_content }
    	end
	end

	def addTo
		@newimage = Image.new()
		if(params[:option]=="save")
			@newimage.parent_id = params[:image_id]
		end
		@newimage.user=current_user
		@newimage.imageName = @image.imageName+params[:filterchoise]
		@newimage.gallery_id= params[:gallery_id]
		path=@image.getPath(@image.picture_url,params[:filterchoise])
		@newimage.inTrash=false
		abpath = File.join(Rails.root, "public",path)
		@newimage.picture=File.new(abpath)
		if @newimage.save
			if(params[:option]=="over")
				@image.delete
			end
			redirect_to [Gallery.find(@newimage.gallery_id),@newimage]
			flash[:notice] =params[:option]+"adsfasdf"
		end	 
	end



	def create
		@filter=Filter.new(filter_params)
		respond_to do |format|
        if @filter.save
         	format.html { redirect_to @filter, notice: 'filter was successfully created.' }
        	format.json { render :show, status: :created, location: @filter }
      	else
        	format.html { render :new }
        	format.json { render json: @filter.errors, status: :unprocessable_entity }
      	end
    end
	end

	def apply 
		@filterchoise = params[:filterchoise]
		@gallery_id = params[:gallery_id]
		@path=@image.getPath(@image.picture_url,@filterchoise)
	end

	private
    	def set_image
    	  @image = Image.find(params[:image_id])
    	end

    	def set_filter
    		@filter = Filter.find(params[:id])
    	end

    	# def set_gallery
    	# 	@gallery = Image.find(params[:gallery_id])
    	# end

    	def filter_params
      	params.require(:filter).permit(:option,:filterchoise,:gallery_id,:image_id,:FilterName,:brightness,:hue,:blur_value)
    	end
    
end