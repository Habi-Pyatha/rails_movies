class ChangeImdbType < ActiveRecord::Migration[7.2]
  def change
    change_column :movies, :imdb_id, :string
  end
end
