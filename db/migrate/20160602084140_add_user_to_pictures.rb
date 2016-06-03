class AddUserToPictures < ActiveRecord::Migration
  def change
    add_column :pictures, :user, :integer
  end
end
