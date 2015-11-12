class Api::V1::CustomsSessionsController < ApplicationController
	def create
    	user_password = params[:session][:password]
    	user_email = params[:session][:email]
    	user = user_email.present? && User.find_by(email: user_email)
      #send = User.new(:email => 'jorgeglezon@gmail.com')
      #mail = UserMailer.welcome_email(send).deliver_now
      #UserMailer.send_email().deliver_now
    	
      if user.valid_password? user_password
      		sign_in user, store: false
      		#user.generate_authentication_token!
      		user.save
      		render json: user, status: 201, location: [:api, user]
    	else
      		render json: { errors: "Email o Password invalido, verifique." }, status: 422
    	end
  	end
end
