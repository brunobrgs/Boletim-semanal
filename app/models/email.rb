# encoding: utf-8
class Email < ActiveRecord::Base
=begin
  Descrição: Controler e emails que recebem os boletins
  Data de criação: 31-12-2010
  Última modificação:
=end

  # Validações
  validates_presence_of :email
  validates_length_of :email, :maximum => 100, :allow_blank => true
  validates_format_of :email, :with => /^([a-zA-Z0-9_\.\-\+])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/, :allow_blank => true

  # Métodos
  before_create :adicionar_data

  #Coloca a data atual no registro. Momento em que foi criado
  def adicionar_data
    self.date = Date.today
  end

end
