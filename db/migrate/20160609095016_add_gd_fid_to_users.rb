class AddGdFidToUsers < ActiveRecord::Migration
  def change
    add_column :users, :gd_fid, :string
  end
end
