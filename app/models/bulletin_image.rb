# encoding: utf-8
class BulletinImage < ActiveRecord::Base
  belongs_to :bulletin_part

  has_attached_file :image

  validates_attachment_presence :image

end
