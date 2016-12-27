# encoding: utf-8

class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.references :user, :null=>false
      t.string :title, :null=>false, :limit=>60
      t.date :day, :null=>false
      t.boolean :enable, :null=>false, :default=>true
      t.timestamps :null=>false
    end
    
    add_index :schedules, :user_id
  end
end
