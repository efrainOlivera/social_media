class UsersController < ApplicationController

	def index
		session[:id] = nil
	end

	# -------login information--------
	def login
		@usr = User.find_by(email: params[:email])
	
		if @usr && @usr.authenticate(params[:password])
			puts "inside here"
			session[:id] = @usr.id
			redirect_to "/land"
		else
			flash[:notice] = "Email and password do not match"
			redirect_to "/"
		end
	end
	# -------User information and validation----
	def regi
		@usr = User.new(user_params)
		@usr.save
		puts @usr.errors.full_messages
		session[:id]=@usr.id
		if @usr.save 
			session[:number] = 99
			redirect_to "/land"
		else
			flash[:error] = "Enter valid information. Name: 'only letters' Email: example@yahoo.com"
			flash[:password] = "NOTE: password must contain 8 or more characters, contain a digit, a lower case character and upper case character."
			redirect_to "/"
		end
	end
	# ---------- user home page and information/messages display -------
	def land
		if session[:id] == ()
			redirect_to "/"
		else
			@find = User.find(session[:id])    #accesing all users info by session[:id]
			@current_users = User.all
			@users = Mss.all.order("created_at DESC")
		end
	end 
	# ----------Comment post from form user home page--------
	def comment
		@usr = Mss.new(messages: params[:content], user_id: params[:id])
		@usr.save
		redirect_to "/land"
	end 
	# ----------Comment deletion href from home/land page--------
	def messageDelete
		@tmss = Mss.find(params[:id])
		if session[:id] === @tmss.user_id
			@del = Mss.find(params[:id]).delete
			redirect_to "/land"
		else
			redirect_to "/land"
		end
	end 
	# ----------message editing href will direct you to editMss rote------
	def editMss
		@commentDisplay = Mss.find(params[:id])
		if session[:id] != @commentDisplay.user_id
			redirect_to "/land"
		end
	end
	# ----------message update, hidden/authenticity token type hidden-------
	def mssUpdate
		@commentUpdate = Mss.find(params[:id])
		if session[:id] === @commentUpdate.user_id
			@commentUpdate.update(mss_params)
			redirect_to "/land"
		else
			flash[:denied] = "Access denied, I see what you are doing!"
			redirect_to "/land"
		end
	end
	# ------Edit user href rout, rout will carry user id/query from land function-----
	def userEdit
		@user_display = User.find(params[:id])
		if session[:id] != @user_display.id
			redirect_to "/"
			flash[:restricted] = "Access denied!"
		end
	end
	# -------User information update through form with hidden/input-----
	def swapUser
		@iden_user = User.find(session[:id])
		@user_find = User.find(params[:id])
		if @iden_user.id != @user_find.id
			redirect_to "/"
			flash[:denied] = "Access denied, I see what you are doing!"
		elsif @user_find.update(user_change)
			redirect_to "/land"
		else
			redirect_to "/user/#{@iden_user.id}/edit"
			flash[:taken_email] = "Use a different email"
		end
	end
	# ------User account and messages in general will be deleted, Note: both user and messages tables are connected------
	def delete
		@current_message = 1
		while @current_message != nil do
			@current_message = Mss.find_by(user_id: session[:id])
			if @current_message == nil 
				break
			end
			@current_message.delete
		end
		@delete_user = User.find(session[:id]).delete
		redirect_to "/"
	end 
	# ------privacy user data from forms will be filter and transfer to specific destination/function source-----
	private
		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation)
		end

		def user_change
			params.require(:user).permit(:name, :email, :avatar)
		end

		def mss_params
			params.require(:mss).permit(:messages)
		end
end