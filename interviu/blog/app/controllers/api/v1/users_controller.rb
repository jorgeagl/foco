class Api::V1::UsersController < ApplicationController
	respond_to :json
  before_filter :set_host_from_request, only: [:create]

#SHOW USER
  	def show
    	respond_with User.find(params[:id])
      UserMailer.test_email().deliver_now

      #Mail.defaults do
      #  delivery_method :smtp, address: "localhost", port: 1025
      #end
      #mail = Mail.new do
      #  from     'me@test.lindsaar.net'
      #  to       'you@test.lindsaar.net'
      #  subject  'Here is the image you wanted'
      #  body     'TEST'
        #add_file :filename => 'somefile.png', :content => File.read('/somefile.png')
      #end
      #mail.deliver! 

  	end

#CREATE USER
	def create
    	user = User.new(user_params)
      #user.skip_confirmation!
    	if user.save
      		render json: user, status: 201, location: [:api, user]
    	else
      		render json: { errors: user.errors }, status: 422
    	end
  	end

#UPDATE USER
  	def update
  		user = User.find(params[:id])

  		if user.update(pass_params)
    		render json: user, status: 200, location: [:api, user]
  		else
    		render json: { errors: user.errors }, status: 422
  		end
	end

#DESTROY USER
	def destroy
		user = User.find(params[:id])
		user.destroy
		head 204
	end


#PRIVATES
  	private 
  		def user_params
  			params.require(:user).permit(:name, :email, :password, :password_confirmation)
  		end

      def pass_params
        params.require(:user).permit(:password)
      end

      def set_host_from_request
        ActionMailer::Base.default_url_options = { host: request.host_with_port }
      end


end
