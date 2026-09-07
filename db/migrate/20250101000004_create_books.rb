class CreateBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.string :isbn
      t.text :description
      t.integer :published_year
      t.integer :total_copies, null: false, default: 1
      t.integer :available_copies, null: false, default: 1
      t.string :cover_image_url
      t.references :author, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end

    add_index :books, :title
    add_index :books, :isbn, unique: true
  end
end
