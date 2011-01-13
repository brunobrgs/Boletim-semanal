# encoding: utf-8
class MessagesController < ApplicationController

  layout "home"

  #Listagem de mensagens
  def index
    @user = user_session
    if !params[:enviadas].blank?
      #Mensagens enviadas
      @mensagens = user_session.mensagens_enviadas
    elsif !params[:deletadas].blank?
      #Mensagens deletadas
      @mensagens = user_session.mensagens_deletadas
    else
      #Mensagens recebidas
      @mensagens = user_session.mensagens_recebidas
    end
  end

  def new
    params[:mensagem].blank? ? @mensagem = Message.new : @mensagem = Message.new(params[:mensagem])
    if user_session.class == User
      @patrocinadores = Sponsor.all_active
    end
  end

  def create
    mensagem = Message.new(params[:mensagem])
    user_session.class == User ? mensagem.user_id = user_session.id : mensagem.sponsor_id = user_session.id
    if mensagem.save
      flash[:notice] = "Mensagem enviada com sucesso."
      redirect_to :action => :index
    else
      flash[:error] = erro(mensagem)
      redirect_to :action => :new, :mensagem => params[:mensagem]
    end
  end

  def show
    @mensagem = Message.find(params[:id])
  end

  def destroy
    mensagem = Message.find(params[:id])
    user_session.class == User ? mensagem.deleted_by_user = DateTime.now : mensagem.deleted_by_sponsor = DateTime.now
    mensagem.save ? flash[:notice] = "Mensagem deletada." : flash[:error] = erro(mensagem)
    redirect_to :action => :index
  end


end
