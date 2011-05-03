require 'spec_helper'

describe Photo do
  
  before(:each) do
    @attr = { :name => "Sample Photo" }
  end
  
  it "should create a new photo entry" do
    Photo.create!(@attr)
  end
  
  it "should require a name" do
    no_name_photo = Photo.new(@attr.merge(:name => ""))
    no_name_photo.should_not be_valid
  end
  
end
