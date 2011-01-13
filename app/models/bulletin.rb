# encoding: utf-8
class Bulletin < ActiveRecord::Base
=begin
  Descrição: Boletins
  Data de criação: 09-01-2010
  Última modificação:
=end

  belongs_to :user
  has_many :bulletin_parts

  validates_presence_of :title, :user_id

  before_create :add_date

  def add_date
    self.date = Date.today
  end

end
