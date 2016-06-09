class AddGdIdToPictures < ActiveRecord::Migration
  def change
    add_column :pictures, :gd_id, :string
  end
end
