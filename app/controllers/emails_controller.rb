# encoding: utf-8
class EmailsController < ApplicationController

  layout "home"

  #Listagem de emails
  def index
    @emails = Email.find(:all, :order => "email")
  end

  def new
    params[:email].blank? ? @email = Email.new : @email = Email.new(params[:email])
  end

  def create
    email = Email.new(params[:email])
    if email.save
      flash[:notice] = "Email criado com sucesso."
      redirect_to :action => :index
    else
      flash[:error] = erro(email)
      redirect_to :action => :new, :email => params[:email]
    end
  end

  def edit
    @email = Email.find(params[:id])
    @email.attributes = params[:email] unless params[:email].blank?
  end

  def update
    email = Email.find(params[:id])
    if email.update_attributes(params[:email])
      flash[:notice] = "Email atualizado com sucesso."
      redirect_to :action => :index
    else
      flash[:error] = erro(email)
      redirect_to :action => :edit, :id => params[:id], :email => params[:email]
    end
  end

  def destroy
    email = Email.find(params[:id])
    email.destroy ? flash[:notice] = "Email deletado." : flash[:error] = erro(email)
    redirect_to :action => :index
  end

end
