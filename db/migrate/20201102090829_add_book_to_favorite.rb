class AddBookToFavorite < ActiveRecord::Migration[5.2]
  def change
    add_column :favorites, :book, :integer
  end
end
