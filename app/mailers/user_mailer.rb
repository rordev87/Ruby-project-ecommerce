class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.account_activation.subject
  default from: 'buithikieu16tclc3@gmail.com'
   def account_activation(user)   
	@user = user  
  mail to: user.email, subject: "Account activation"  
	end
  def password_reset  
  @greeting = "Hi"
    mail to: "to@example.org" 
	end
end

