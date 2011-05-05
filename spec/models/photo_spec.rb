require 'spec_helper'

describe Photo do
  
  before(:each) do
    @valid_jpeg = 'spec/fixtures/images/sample_image.jpg'
    @sample_png = 'spec/fixtures/images/git-cheat-sheet-large.png'
    @attr = { 
      :name => "Sample Photo",
      :description => "Sample Description",
      :image => Rails.root.join(@valid_jpeg).open
    }
  end
  
  it "should create a new photo entry" do
    Photo.create!(@attr)
  end
  
  it "should require a name" do
    no_name_photo = Photo.new(@attr.merge(:name => ""))
    no_name_photo.should_not be_valid
  end
  
  it "should require a description" do
    no_desc_photo = Photo.new(@attr.merge(:description => ""))
    no_desc_photo.should_not be_valid
  end
  
  it "should require an image" do
    no_image_photo = Photo.new(@attr.merge(:image => nil))
    no_image_photo.should_not be_valid
  end
  
  it "should require a jpeg" do
    non_jpeg_photo = Photo.new(@attr.merge(:image => Rails.root.join(@sample_png).open))
    non_jpeg_photo.should_not be_valid
  end
  
  it "should return an id_list" do
    Photo.id_list.should_not be_nil 
  end
  
end
