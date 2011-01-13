# encoding: utf-8
class Interface < ActiveRecord::Base
=begin
  Descrição: Layout do boletim
  Data de criação: 07-01-2010
  Última modificação:
=end

  has_many :components

  def altura
    al = 0
    self.components.each do |c|
      al += c.height.to_i
    end
    al
  end

end
