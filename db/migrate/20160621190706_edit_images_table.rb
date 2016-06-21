class EditImagesTable < ActiveRecord::Migration
  def change
    rename_column :movies, :images, :image
  end
end
