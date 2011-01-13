# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def link_to_if(condition, string, options)
    condition ? link_to(string, options)  : ""
  end

  def link_to_remote_if(condition, string, options)
    condition ? link_to_remote(string, options)  : ""
  end

  def confere_permissao(metodo,controlador)
    return true
    #    if session[:admin]
    #      true
    #    elsif session[:user] and Permissao.find(:first, :select => 'id', :conditions => "metodo = '#{metodo}'")
    #      if Relacoesfuncionario.find(:first, :include => [:permissao],:conditions => "funcionario_id = #{session[:user]} and relacionado_type = 'Permissao' and permissoes.metodo = '#{metodo}'")
    #        true
    #      else
    #        false
    #      end
    #    else
    #      true
    #    end
  end

  def ApplicationHelper.erro(objeto)
    erro = ""
    controle = []
    objeto.errors.each do |a,b|
      unless controle.include?(b)
        b.gsub!("Validation failed: ", "")
        erro <<  "- " + b + "<br />"
      end
    end
    erro
  end

  def user?
    session[:u_id].blank? ? false : true
  end

  def sponsor?
    session[:s_id].blank? ? false : true
  end

  def notice
    "layouts/notice"
  end

  def tooltip
    "layouts/tooltip"
  end

  def validate
    "layouts/validate"
  end

end
