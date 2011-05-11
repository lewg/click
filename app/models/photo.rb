# == Schema Information
# Schema version: 20110505110323
#
# Table name: photos
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  taken_on           :date
#  exposure           :string(255)
#  f_stop             :string(255)
#  focal_length       :string(255)
#  iso                :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#  description        :string(255)
#

class Photo < ActiveRecord::Base
  has_attached_file :image, :styles => { :display => "1050x700>", :rss => "400x300>" }
  
  validates :name, :presence => true
  validates :description, :presence => true
  
  validates_attachment_presence :image
  validates_attachment_content_type :image, :content_type => ['image/jpeg']
  
  scope :sorted, order('taken_on DESC')
  
  before_save :load_exif
  
  def load_exif
    # Pull the Exif data
    exif_data = EXIFR::JPEG.new(self.image.to_file)
    return if exif_data.nil? or not exif_data.exif?
    # Set the attributes
    self.exposure = exif_data.exposure_time.to_s
    self.f_stop = exif_data.f_number.to_f.to_s
    self.focal_length = exif_data.focal_length.to_f.round.to_s
    self.iso = exif_data.iso_speed_ratings
    self.taken_on = exif_data.date_time.to_date
  rescue
    false
  end
  
  def info_line
    "#{self.focal_length}mm #{self.f_stop}f #{self.exposure} ISO #{self.iso}"
  end
  
  def self.id_list
    @id_list = Array.new
    self.sorted.each { |photo| @id_list << photo.id }
    @id_list
  end
  
  def next_id
    @id_list = Photo.id_list
    @id_list.last.id == self.id ? @id_list.first : @id_list[@id_list.index(self.id) + 1]
  end
  
  def prev_id
    @id_list = Photo.id_list
    @id_list.first.id == self.id ? @id_list.last : @id_list[@id_list.index(self.id) - 1]
  end
  
end
