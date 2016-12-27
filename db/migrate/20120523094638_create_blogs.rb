class CreateBlogs < ActiveRecord::Migration
  def up
    create_table :blogs do |t|
      t.references :user, :null=>false
      t.references :blog_category, :null=>false
      t.string :title,:null=>false, :limit=>60
      t.string :description, :null=>false, :limit=>255
      t.string :photo
      t.integer :blog_comments_count, :default=>0, :null=>false
      t.integer :count, :null=>false, :default=>0
      t.boolean :enable, :null=>false, :default=>true
      t.timestamps :null=>false
    end

    create_table :blog_contents do |t|
      t.text :content
    end

    create_table :blog_comments do |t|
      t.references :blog,:null=>false
      t.references :user
      t.string :title, :null=>false, :limit=>60
      t.string :name,:limit=>60
      t.string :encrypted_password,:limit=>40
      t.string :salt,:limit=>40
      t.text :content,:null=>false
      t.timestamps :null=>false
    end

    add_index :blogs, :user_id
    add_index :blogs, :blog_category_id
    add_index :blog_comments, :blog_id
    add_index :blog_comments, :user_id

#    Blog.create_translation_table! :title => {:type => :string, :limit=>60,:null=>false},:description => {:type => :string, :limit=>255,:null=>false}
#    BlogContent.create_translation_table! :content=>{:type => :text,:null=>false}
#    BlogComment.create_translation_table! :title => {:type => :string, :limit=>60,:null=>false}, :content=>{:type => :text,:null=>false }
  end

  def down
    drop_table :blogs
    drop_table :blog_contents
    drop_table :blog_comments
#    Blog.drop_translation_table!
#    BlogContent.drop_translation_table!
#    BlogComment.drop_translation_table!
  end
end
