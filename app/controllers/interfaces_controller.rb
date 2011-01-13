# encoding: utf-8
class InterfacesController < ApplicationController

  layout "home"

  def index
    @interfaces = Interface.find(:all, :order => "name")
  end

  def new
    params[:interface].blank? ? @interface = Interface.new : @interface = Interface.new(params[:interface])
  end

  def create
    interface = Interface.new(params[:interface])
    if interface.save
      flash[:notice] = "Interface criada com sucesso."
      redirect_to :action => :index
    else
      flash[:error] = erro(interface)
      redirect_to :action => :new, :interface => params[:interface]
    end
  end

  def edit
    @interface = Interface.find(params[:id])
    @interface.attributes = params[:interface] unless params[:interface].blank?
  end

  def update
    interface = Interface.find(params[:id])
    if interface.update_attributes(params[:interface])
      flash[:notice] = "Interface atualizado com sucesso."
      redirect_to :action => :index
    else
      flash[:error] = erro(interface)
      redirect_to :action => :edit, :id => params[:id], :interface => params[:interface]
    end
  end

  def destroy
    interface = Interface.find(params[:id])
    interface.destroy ? flash[:notice] = "Interface deletada." : flash[:error] = erro(interface)
    redirect_to :action => :index
  end

  def show
    @interface = Interface.find(params[:id])
    @component = Component.new
  end

  def save_component
    if params[:component_id].blank?
      #Criando um novo componente
      @component = Component.new(params[:componente])
    else
      #Editando um componente existente
      @component = Component.find(params[:component_id])
      @component.attributes = params[:componente]
    end
    unless @component.save
      flash[:error] = erro(@component)
    end

    @interface = Interface.find(params[:id])
    render :update do |page|
      page.replace_html "interface", :partial => "interface"
    end

  end

  def edit_component
    @component = Component.find(params[:component_id])
    render :update do |page|
      page.replace_html "component", :partial => "component"
    end
  end

  def remove_component
    component = Component.find(params[:component_id])
    unless component.destroy
      flash[:error] = erro(component)
    end
    @interface = Interface.find(params[:id])
        render :update do |page|
      page.replace_html "layout", :partial => "layout"
    end
  end

end
