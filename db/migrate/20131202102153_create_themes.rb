# encoding: utf-8

class CreateThemes < ActiveRecord::Migration
  def change
    create_table :themes do |t|
      t.string :title
      t.boolean :enable, :null=>false, :default=>true    
      t.timestamps :null=>false
    end
  end
end
