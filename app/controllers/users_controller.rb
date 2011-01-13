# encoding: utf-8
class UsersController < ApplicationController

  layout "home"

  #Listagem de usuários
  def index
    @users = User.find(:all, :order => "active desc, name")
  end

  #Altera o status do usuário para inativo, impedindo que ele possa acessar o sistema
  def inativar
    user = User.find(params[:id])
    user.active = false
    if user.save
      flash[:notice] = "Usuário inativado."
    else
      flash[:error] = erro(user)
    end
    redirect_to :action => :index
  end

  #Altera o status do usuário para ativo
  def ativar
    user = User.find(params[:id])
    user.active = true
    if user.save
      flash[:notice] = "Usuário ativado."
    else
      flash[:error] = erro(user)
    end
    redirect_to :action => :index
  end

  def new
    params[:user].blank? ? @user = User.new : @user = User.new(params[:user])
  end

  def create
    user = User.new(params[:user])
    if user.save
      flash[:notice] = "Usuário criado com sucesso."
      redirect_to :action => :index
    else
      flash[:error] = erro(user)
      redirect_to :action => :new, :user => params[:user]
    end
  end

  def edit
    @user = User.find(params[:id])
    @user.attributes = params[:user] unless params[:user].blank?
  end

  def update
    user = User.find(params[:id])
    if user.update_attributes(params[:user])
      flash[:notice] = "Usuário atualizado com sucesso."
      redirect_to :action => :index
    else
      flash[:error] = erro(user)
      redirect_to :action => :edit, :id => params[:id], :user => params[:user]
    end
  end

end
