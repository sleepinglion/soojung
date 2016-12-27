# encoding: utf-8

class CreateFaqs < ActiveRecord::Migration
  def change
    create_table :faq_categories do |t|
      t.string :title,:null=>false
      t.boolean :enable, :null=>false, :default=>true
      t.timestamps :null=>false
    end  
  
    create_table :faqs do |t|
      t.references :faq_category,:null=>false      
      t.string :title,:null=>false
      t.integer :count,:default=>0,:null=>false
      t.timestamps :null=>false
    end
    
    create_table :faq_contents do |t|
      t.boolean :html,:default=>false,:null=>false      
      t.string :content 
    end
    
    add_index :faqs, :faq_category_id 
  end
end
