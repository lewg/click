# == Schema Information
# Schema version: 20110502205348
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
#

class Photo < ActiveRecord::Base
  has_attached_file :image, :styles => { :display => "900x500>", :thumb => "100x100>" }
  
  validates :name, :presence => true
  
  validates_attachment_presence :image
  validates_attachment_content_type :image, :content_type => ['image/jpeg']
  
  def before_save
    if self.image_content_type == "image/jpeg"
      # Pull the Exif data
      exif_data = EXIFR::JPEG.new(self.image.to_file)
      # Set the attributes
      self.exposure = exif_data.exposure_time.to_s
      self.f_stop = exif_data.f_number.to_f.to_s
      self.focal_length = exif_data.focal_length.to_f.round.to_s
      self.iso = exif_data.iso_speed_ratings
      self.taken_on = exif_data.date_time.to_date
    end
  end
  
end
