# encoding: utf-8
class BulletinsController < ApplicationController

  layout "home"

  def index
    @bulletins = Bulletin.find(:all, :order => "date")
  end

  def new
    params[:bulletin].blank? ? @bulletin = Bulletin.new : @bulletin = Bulletin.new(params[:bulletin])
    #    @bulletin_part = BulletinPart.new
    #    @interfaces = Interface.find(:all, :order => "name")
    #    @text = BulletinText.new
    #    @image = BulletinImage.new
  end

  def create
    bulletin = Bulletin.new(params[:bulletin])
    bulletin.user_id = user_session.id
    if bulletin.save
      flash[:notice] = "Boletim criado com sucesso."
      redirect_to :action => :index
    else
      flash[:error] = erro(bulletin)
      redirect_to :action => :new, :bulletin => params[:bulletin]
    end
  end

  def edit
    @bulletin = Bulletin.find(params[:id])
    @bulletin.attributes = params[:bulletin] unless params[:bulletin].blank?
  end

  def update
    bulletin = Bulletin.find(params[:id])
    if bulletin.update_attributes(params[:bulletin])
      flash[:notice] = "Bulletin atualizado com sucesso."
      redirect_to :action => :index
    else
      flash[:error] = erro(bulletin)
      redirect_to :action => :edit, :id => params[:id], :bulletin => params[:bulletin]
    end
  end

  def destroy
    bulletin = Bulletin.find(params[:id])
    bulletin.destroy ? flash[:notice] = "Bulletin deletada." : flash[:error] = erro(bulletin)
    redirect_to :action => :index
  end

  def show
    @bulletin = Bulletin.find(params[:id])
    @interfaces = Interface.find(:all, :order => "name")
    @part = BulletinPart.new
  end



  
  ############# PARTS ####################

  def save_part
    if params[:part_id].blank?
      #Criar uma nova parte
      part = BulletinPart.new(params[:bulletin_part])
      part.bulletin_id = params[:id]
    else
      #Editar uma parte
      part = BulletinPart.find(params[:part_id])
      part.attributes = params[:bulletin_part]
    end

    unless part.save
      flash[:error] = erro(part)
    end

    @bulletin = Bulletin.find(params[:id])
    render :update do |page|
      page.replace_html "parts", :partial => "parts"
    end
  end

  def edit_part
    @part = BulletinPart.find(params[:part_id])
    @interfaces = Interface.find(:all, :order => "name")
    render :update do |page|
      page.replace_html "form_part", :partial => "form_part"
    end
  end

  def delete_part
    part = BulletinPart.find(params[:part_id])
    unless part.destroy
      flash[:error] = erro(part)
    end
    @bulletin = Bulletin.find(params[:id])
    render :update do |page|
      page.replace_html "parts", :partial => "parts"
    end
  end

  def show_part
    @part = BulletinPart.find(params[:part_id])
    #    render :update do |page|
    #      page.replace_html "show_bolletin", :partial => "show_part"
    #    end
  end



  ################# TXT ###################################

  def add_txt
    @part = BulletinPart.find(params[:part_id])
    @part_txt = BulletinText.new
    render :update do |page|
      page.replace_html "form_part", :partial => "form_txt"
    end
  end

  def save_txt
    part_txt = BulletinText.new(params[:bulletin_text])
    part_txt.bulletin_part_id = params[:part_id]
    unless part_txt.save
      flash[:error] = erro(part_txt)
    else
      flash[:notice] = "Texto adicionado com sucesso."
    end

    @part = BulletinPart.find(params[:part_id])
    @part_txt = BulletinText.new
    render :update do |page|
      page.replace_html "form_part", :partial => "form_txt"
    end
  end

  def delete_txt
    part_txt = BulletinText.find(params[:txt_id])
    unless part_txt.destroy
      flash[:error] = erro(part_txt)
    end
    @part = BulletinPart.find(params[:part_id])
    render :update do |page|
      page.replace_html "show_bolletin", :partial => "show_part"
    end
  end



  ################# IMAGES ###################################

  def add_img
    @part = BulletinPart.find(params[:part_id])
    @part_img = BulletinImage.new
    render :update do |page|
      page.replace_html "form_part", :partial => "form_img"
    end
  end

  def save_img
    part_img = BulletinImage.new(params[:bulletin_image])
    part_img.bulletin_part_id = params[:part_id]
    unless part_img.save
      flash[:error] = erro(part_img)
    else
      flash[:notice] = "Imagem adicionada com sucesso."
    end

    @part = BulletinPart.find(params[:part_id])
    @part_img = BulletinImage.new
    responds_to_parent do
      render :update do |page|
        page.replace_html "form_part", :partial => "form_img"
      end
    end
  end

  def delete_img
    part_img = BulletinImage.find(params[:img_id])
    unless part_img.destroy
      flash[:error] = erro(part_img)
    end
    @part = BulletinPart.find(params[:part_id])
    render :update do |page|
      page.replace_html "show_bolletin", :partial => "show_part"
    end
  end


  ############# BOLETIM NO LAYOUT #############

  def show_in_layout
    @bulletin = Bulletin.find(params[:id])
  end

end
