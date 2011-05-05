require 'spec_helper'

describe "Photos" do
  describe "GET /photos.json" do
    it "returns sucessfully" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get photos_path, :format => 'json'
      response.status.should be(200)
    end
  end
end
