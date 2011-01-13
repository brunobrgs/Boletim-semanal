# encoding: utf-8
class Sponsor < ActiveRecord::Base
=begin
  Descrição: Patrocinadores com interesse de anunciar suas marcas
  Data de criação: 31-12-2010
  Última modificação:
=end

  has_many :messages

  attr_accessor :password_confirmation

  # Validações
  validates_presence_of :username, :password, :name, :email, :address, :city
  validates_uniqueness_of :username, :allow_blank => true
  validates_length_of :username, :maximum => 30, :allow_blank => true
  validates_length_of :password, :maximum => 255, :allow_blank => true
  validates_length_of :name, :company, :maximum => 150, :allow_blank => true
  validates_length_of :email, :city, :maximum => 100, :allow_blank => true
  validates_length_of :phone, :cell_phone, :maximum => 10, :allow_blank => true
  validates_length_of :address, :maximum => 200, :allow_blank => true
  validates_format_of :email, :with => /^([a-zA-Z0-9_\.\-\+])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/, :allow_blank => true
  validates_confirmation_of :password

  # Métodos
  before_create :adicionar_data
  before_save :criptografar_password

  #Coloca a data atual no registro. Momento em que foi criado
  def adicionar_data
    self.date = Date.today
  end

  def criptografar_password
    self.password = Digest::SHA256.hexdigest(self.password)
  end

  def mensagens_recebidas
    Message.find(:all, :conditions => "user_id is not null and sponsor_id = #{self.id} and deleted_by_sponsor is null", :order => "date desc")
  end

  def mensagens_enviadas
    Message.find(:all, :conditions => "sponsor_id is not null and user_id is null and deleted_by_sponsor is null", :order => "date desc")
  end

  def mensagens_deletadas
    Message.find(:all, :conditions => "sponsor_id = #{self.id} and deleted_by_sponsor is not null", :order => "date desc")
  end

end

#Todos patrocinadores ativos, ordenados por nome
def Sponsor.all_active
  Sponsor.find(:all, :conditions => "active", :order => "name")
end