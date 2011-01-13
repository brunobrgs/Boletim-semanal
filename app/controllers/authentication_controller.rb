# encoding: utf-8
class AuthenticationController < ApplicationController

  def login
    render :layout => 'login'
  end

  def home
    if session[:u_id].blank? and session[:s_id].blank?
      user = User.find(:first, :conditions => "active and username = '#{params[:user]}' and password = '#{Digest::SHA256.hexdigest(params[:password])}'")
      #Se não encontrar um usuário, um patrocinador será buscado
      user = Sponsor.find(:first, :conditions => "active and username = '#{params[:user]}' and password = '#{Digest::SHA256.hexdigest(params[:password])}'") if user.blank?
      if user.blank?
        flash[:error] = "Erro na autenticação, tente novamente."
        redirect_to :action => :login
      else
        user.class == User ? session[:u_id] = user.id : session[:s_id] = user.id
        render :layout => 'home'
      end
    else
      render :layout => 'home'
    end
  end

  def logout
    session[:u_id] = nil
    session[:s_id] = nil
    redirect_to root_url
  end

end
