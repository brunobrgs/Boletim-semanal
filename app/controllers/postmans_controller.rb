# encoding: utf-8
class PostmansController < ApplicationController

  def send_mail

    Postman.deliver_email(params[:id])

    redirect_to :controller => :bulletins, :action => :show_part, :id => params[:id], :part_id => params[:part_id]

  end

end
