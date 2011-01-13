# encoding: utf-8
class Message < ActiveRecord::Base
=begin
  Descrição: Mensagens, enviadas e recebidas por usuários e patrocinadores
  Data de criação: 05-01-2010
  Última modificação:
=end

  belongs_to :user
  belongs_to :sponsor

  validates_presence_of :text
  validates_length_of :text, :maximum => 500

  before_create :adicionar_data

  #Ao criar uma msg, sua data é adicionada
  def adicionar_data
    self.date = DateTime.now
  end

  def deleted?(user)
    ((user.class == User and self.deleted_by_user) or (user.class == Sponsor and self.deleted_by_sponsor)) ? true : false
  end

end
