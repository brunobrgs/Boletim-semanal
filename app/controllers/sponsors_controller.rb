# encoding: utf-8
class SponsorsController < ApplicationController

  layout "home"

  #Listagem de usuários
  def index
    @sponsors = Sponsor.find(:all, :order => "active desc, name")
  end

  #Altera o status do patrocinador para inativo, impedindo que ele possa acessar o sistema
  def inativar
    sponsor = Sponsor.find(params[:id])
    sponsor.active = false
    if sponsor.save
      flash[:notice] = "Patrocinador inativado."
    else
      flash[:error] = erro(sponsor)
    end
    redirect_to :action => :index
  end

  #Altera o status do patrocinador para ativo
  def ativar
    sponsor = Sponsor.find(params[:id])
    sponsor.active = true
    if sponsor.save
      flash[:notice] = "Patrocinador ativado."
    else
      flash[:error] = erro(sponsor)
    end
    redirect_to :action => :index
  end

  def new
    params[:sponsor].blank? ? @sponsor = Sponsor.new : @sponsor = Sponsor.new(params[:sponsor])
  end

  def create
    sponsor = Sponsor.new(params[:sponsor])
    if sponsor.save
      flash[:notice] = "Patrocinador criado com sucesso."
      redirect_to :action => :index
    else
      flash[:error] = erro(sponsor)
      redirect_to :action => :new, :sponsor => params[:sponsor]
    end
  end

  def edit
    @sponsor = Sponsor.find(params[:id])
    @sponsor.attributes = params[:sponsor] unless params[:sponsor].blank?
  end

  def update
    sponsor = Sponsor.find(params[:id])
    if sponsor.update_attributes(params[:sponsor])
      flash[:notice] = "Patrocinador atualizado com sucesso."
      redirect_to :action => :index
    else
      flash[:error] = erro(sponsor)
      redirect_to :action => :edit, :id => params[:id], :sponsor => params[:sponsor]
    end
  end

  def show
    @sponsor = Sponsor.find(params[:id])
  end

end
