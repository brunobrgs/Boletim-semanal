# encoding: utf-8
class Component < ActiveRecord::Base
=begin
  Descrição: Objetos que compoem o layout
  Data de criação: 07-01-2010
  Última modificação:
=end

  belongs_to :interface

  validates_presence_of :ident, :width, :height

end
