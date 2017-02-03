class SettingController < ActiveRecord::Base
  validates_presence_of :title, :controller
  has_one :setting_controller_photo, :foreign_key => :id, :dependent => :destroy
  accepts_nested_attributes_for :setting_controller_photo, :allow_destroy => true

  def order
    if self.desc
      return 'id desc'
    else
      return 'id asc'
    end
  end
end
