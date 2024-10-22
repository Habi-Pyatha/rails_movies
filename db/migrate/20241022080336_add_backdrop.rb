class AddBackdrop < ActiveRecord::Migration[7.2]
  def change
    add_column :movies, :backdrop_path, :string
  end
end
