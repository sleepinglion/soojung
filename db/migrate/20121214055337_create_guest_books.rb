class CreateGuestBooks < ActiveRecord::Migration
  def change
    create_table :guest_books do |t|
      t.references :user
      t.string :title,:limit=>60,:null=>false
      t.string :name,:limit=>60
      t.string :encrypted_password,:limit=>40
      t.string :salt, :limit=>100
      t.integer :guest_book_comments_count,:default=>0,:null=>false
      t.integer :count, :null=>false, :default=>0
      t.boolean :enable, :null=>false, :default=>true
      t.timestamps :null=>false
    end

    create_table :guest_book_contents do |t|
      t.text :content,:null=>false
    end

    create_table :guest_book_comments do |t|
      t.references :guest_book,:null=>false
      t.references :user
      t.string :name,:limit=>60
      t.string :encrypted_password,:limit=>40
      t.string :salt,:limit=>40
      t.text :content,:null=>false
      t.timestamps :null=>false
    end

    add_index :guest_books, :user_id
    add_index :guest_book_comments, :user_id
    add_index :guest_book_comments, :guest_book_id
  end
end
