class BusinessPic < ActiveRecord::Base
  belongs_to :business
  belongs_to :user
  validates_presence_of :image
  mount_uploader :image, ImageUploader
end
