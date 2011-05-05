class PhotosController < ApplicationController
  respond_to :json, :html
  
  # GET /photos.json
  def index
    
    @id_list = { :id_list => Array.new }
    Photo.find(:all, :order => 'taken_on desc').each { |photo| @id_list[:id_list] << photo.id }

    respond_to do |format|
      format.json { respond_with @id_list }
    end
  end

  # GET /photos/1
  # GET /photos/1.xml
  def show
    @photo = Photo.find(params[:id])
    
    photo_info_line = "#{@photo.focal_length}mm #{@photo.f_stop}f #{@photo.exposure} ISO #{@photo.iso}"
    @photo_json = { 
      'title' => @photo.name,
      'taken' => @photo.taken_on.strftime('%b %d, %Y'),
      'info' => photo_info_line,
      'url' => @photo.image.url(:display)
    }

    respond_to do |format|
      format.html # show.html.erb
      format.json { respond_with @photo_json }
    end
  end

end