class CreatePhotos < ActiveRecord::Migration
  def self.up
    create_table :photos do |t|
      t.string :name
      t.date :taken_on
      t.string :exposure
      t.string :f_stop
      t.string :focal_length
      t.string :lens
      t.string :iso

      t.timestamps
    end
  end

  def self.down
    drop_table :photos
  end
end
