class CreateMovies < ActiveRecord::Migration[7.2]
  def change
    create_table :movies do |t|
      t.string :original_title
      t.text :overview
      t.text :poster_path
      t.integer :runtime
      t.string :status
      t.integer :imdb_id
      t.integer :tmdb_id
      t.float :vote_average
      t.integer :vote_count
      t.timestamps
    end
  end
end
