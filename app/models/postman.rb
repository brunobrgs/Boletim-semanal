# encoding: utf-8
class Postman < ActionMailer::Base

  def email(id)
    @bulletin = Bulletin.find(id)

    @recipients   = ["bruno.rails@gmail.com"]
    @from         = 'no-reply@boletim_cultural.com'
    @subject      = "Boletim semanal"
    @sent_on = Time.now
    @content_type = "text/html"
    body :bulletin => @bulletin

  end


end
