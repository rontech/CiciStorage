class AddTempFileToPictures < ActiveRecord::Migration
  def change
    add_column :pictures, :temp_file, :string
  end
end
