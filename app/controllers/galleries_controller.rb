class GalleriesController < ApplicationController

before_action :set_gallery, only: [:show, :edit, :update, :destroy]
  def new
  	@gallery = Gallery.new
  end

  def edit
    @gallery = Gallery.find(params[:id])
  end

  def show
    @images = @gallery.getImg current_user.id
  end

  def index
    @galleries = Gallery.all
    
  end

  def shared_gallery
    @sharedImgs = SharedImage.where(user_id: current_user.id)
    imageids = @sharedImgs.uniq.pluck(:image_id)
    if(imageids)
      @images = Image.find(imageids)
    end
  end

  def create
    @gallery = Gallery.new(gallery_params)
    @gallery.user_id = current_user.id
    respond_to do |format|
      if @gallery.save
        format.html { redirect_to @gallery, notice: 'gallery was successfully created.' }
        format.json { render :show, status: :created, location: @gallery }
      else
        format.html { render :new }
        format.json { render json: @gallery.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @gallery.update(gallery_params)
        format.html { redirect_to @gallery, notice: 'gallery was successfully updated.' }
        format.json { render :show, status: :ok, location: @gallery }
      else
        format.html { render :edit }
        format.json { render json: @gallery.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gallerys/1
  # DELETE /gallerys/1.json
  def destroy
    @gallery.destroy
    respond_to do |format|
      format.html { redirect_to galleries_url, notice: 'gallery was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gallery
      @gallery = Gallery.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def gallery_params
      params.require(:gallery).permit(:name)
    end
end
