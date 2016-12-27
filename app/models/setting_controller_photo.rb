require 'carrierwave/orm/activerecord'

class SettingControllerPhoto < ActiveRecord::Base
  validates_presence_of :photo, :alt
  belongs_to :setting_controller, :foreign_key => :id, :autosave=>true
  accepts_nested_attributes_for :setting_controller, :allow_destroy => true  
  mount_uploader :photo, ResourceUploader  
end
