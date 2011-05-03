class RemoveLensFromPhoto < ActiveRecord::Migration
  def self.up
    remove_column :photos, :lens
  end

  def self.down
    add_column :photos, :lens, :string
  end
end
