# encoding: utf-8

class CreateAdPositions < ActiveRecord::Migration
  def change
    create_table :ad_positions do |t| 
      t.string :title,:limit=>60, :null=>false
      t.string :position, :limit=>20, :null=>false
      t.boolean :enable, :null=>false, :default=>true
      t.timestamps :null=>false
    end
    
    add_index :ad_positions, :title, :unique => true
    add_index :ad_positions, :position, :unique => true
  end
end
