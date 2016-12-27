# encoding: utf-8

class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.references :theme, :null=>false
      t.string :favicon
      t.boolean :use_header, :null=>false      
      t.boolean :use_footer, :null=>false
      t.timestamps :null=>false
    end
    
    add_index :settings, :theme_id
  end
end
