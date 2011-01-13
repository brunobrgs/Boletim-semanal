# encoding: utf-8
class BulletinPart < ActiveRecord::Base
=begin
  Descrição: Partes do boletim
  Data de criação: 09-01-2010
  Última modificação:
=end


  belongs_to :bulletin
  belongs_to :interface
  has_many :bulletin_images
  has_many :bulletin_texts

  validates_presence_of :title, :bulletin_id, :interface_id, :sequence_number

end
