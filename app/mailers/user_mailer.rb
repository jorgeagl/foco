class UserMailer < ApplicationMailer
	
  	def welcome_email(user)
    	@user = user
    	mail(to: @user.email, subject: 'Welcome ')
  	end

  	def test_email()
  		mail to: 'jorgeglezon@gmail.com', :subject => "Test mail"  		
  	end
end
