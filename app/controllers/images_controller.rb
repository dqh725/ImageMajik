class ImagesController < ApplicationController
  before_action :set_image, only: [:show, :edit,:update, :destroy,:restore]
  before_action :set_gallery, except: [:select, :share, :trashIndex, :restore,:emptytrash,:versionIndex]



  def index
    @images = Image.where(inTrash:false)

  end

  def trashIndex
    @images =Image.where(inTrash:true)
  end

  def versionIndex
    @id = params[:image_id]
    @children = Image.where(parent_id:@id)
  end

  def emptytrash
    Image.where(:inTrash => true).destroy_all
        
    render :trashIndex
  end


  def show
    @image=Image.find(params[:id])
  end


  def new
    @image = Image.new
  end


  def edit
  end

  def select
    @id_list = params[:image_ids]
  end

  def share
      @images = Image.find(params[:id_list].split(' '))
      @emails = params[:user_emails].split(/\s*,\s*/)
      if @emails.empty?
        flash[:notice] = "Error: at least has one email"
      else
        @emails.each do |email|
          @images.each do |image|
            if User.exists?(email: email)
              userID = User.find_by_email(email).id
              if !SharedImage.exists?(user_id:userID,image_id:image.id)
                sharedImage = SharedImage.new()
                sharedImage.user_id =userID
                sharedImage.image_id = image.id
                sharedImage.save
              else 
                flash[:notice] = "already shared with #{image.id}"
              end
            else 
              flash[:notice] = "user doesn't exist"
            end
          end
        end
      end


  end

  # POST /images
  # POST /images.json
  def create

    @image = Image.new(image_params)
    @image.user=current_user
    @image.gallery_id = params[:gallery_id]
    @image.inTrash = false
    respond_to do |format|
      if @image.save
        format.html { redirect_to [@gallery,@image], notice: 'Image was successfully created.' }
        format.json { render :show, status: :created, location: @image }
      else
        format.html { render :new }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /images/1
  # PATCH/PUT /images/1.json
  def update
    respond_to do |format|
      if @image.update(image_params)
        format.html { redirect_to [@gallery,@image], notice: 'Image was successfully updated.' }
        format.json { render :show, status: :ok, location: @image }
      else
        format.html { render :edit }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /images/1
  # DELETE /images/1.json
  def destroy
    @image.inTrash = true
    @image.save
    respond_to do |format|
      format.html { redirect_to @gallery, notice: 'Image is in Trash Folder' }
      format.json { head :no_content }
    end
  end

  def restore
    @image.inTrash=false
    @image.save
    respond_to do |format|
      if @image.save
        format.html{redirect_to images_trash_new_path, notice: 'Image is being restored'}
        format.json {head :no_content}
      else
        format.html {render :trashIndex}
        format.json{render json: @image.errors, status: :unprocessable_entity}
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gallery
      @gallery = Gallery.find(params[:gallery_id])
    end
    def set_image
      @image = Image.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_params
      params.require(:image).permit(:gallery_id,:picture,:imageName)
    end
end
