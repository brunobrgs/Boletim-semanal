# encoding: utf-8

# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  before_filter :logged?, :except => [:login, :home]

  def logged?
    if session[:u_id].blank? and session[:s_id].blank?
      flash[:error] = "Por favor. Realize a autenticação."
      redirect_to root_url
    end
  end

  def remover_div
    render :update do |pagina|
      pagina << "el = document.getElementById('#{params[:div]}')"
      pagina << "el.style.display = 'none';"
    end
  end

  def erro(objeto)
    erro = ""
    controle = []
    objeto.errors.full_messages.each do |b|
      unless controle.include?(b)
        controle << b
        erro <<  b.force_encoding("UTF-8") + "<br \>"
      end
    end
    erro
  end

  def user_session
    (return User.find(session[:u_id])) unless session[:u_id].blank?
    (return Sponsor.find(session[:s_id])) unless session[:s_id].blank?
  end

end
