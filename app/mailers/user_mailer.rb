class UserMailer < ApplicationMailer
  default from: "admin@rottenmangoes.com"
  layout 'mailer'

  def delete_email(user)
    @user = user
    mail(to: user.email, subject: "Your account has been deleted") do |format|
      format.html {render 'delete_mail'}
    end
  end


end
