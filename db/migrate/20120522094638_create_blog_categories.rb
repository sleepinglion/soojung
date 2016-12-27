class CreateBlogCategories < ActiveRecord::Migration
  def up
    create_table :blog_categories do |t|
      t.references :user, :null=>false
      t.references :blog_category
      t.string :title, :null=>false, :limit=>60
      t.integer :blogs_count, :null=>false, :default=>false
      t.integer :blog_categories_count, :null=>false, :default=>false
      t.boolean :enable, :null=>false, :default=>true
      t.boolean :leaf, :default=>true
      t.timestamps :null=>false
    end

    add_index :blog_categories, :title,  :unique => true
    add_index :blog_categories, :blog_category_id
    add_index :blog_categories, :user_id

#    BlogCategory.create_translation_table! :title => {:type => :string, :limit=>60}
  end

  def down
    drop_table :blog_categories
    #BlogCategory.drop_translation_table!
  end
end
