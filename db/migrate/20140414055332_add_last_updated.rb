# encoding: utf-8

class AddLastUpdated < ActiveRecord::Migration
  def change
    add_column :resources, :last_updated, :datetime, :null=>false, :default=>Time.now 
  end
end