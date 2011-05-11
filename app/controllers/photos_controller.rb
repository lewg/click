class PhotosController < ApplicationController
  respond_to :json
  
  # GET /photos.json
  def index
    @id_list = {:id_list => Photo.id_list }
    respond_with @id_list
  end

  # GET /photos/1.json
  def show
    @photo = Photo.find(params[:id])
        
    @photo_json = { 
      'title' => @photo.name,
      'description' => @photo.description,
      'taken' => @photo.taken_on.strftime('%b %d, %Y'),
      'info' => @photo.info_line,
      'url' => @photo.image.url(:display),
      'next_id' => @photo.next_id,
      'prev_id' => @photo.prev_id
    }

    respond_with @photo_json

  end
  
  # GET /photos/first.json
  def first
    params[:id] = Photo.id_list.first
    show()
  end

end