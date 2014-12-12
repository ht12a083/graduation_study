class MicropostsController < ApplicationController
	before_action :signed_in_user, only: [:create, :destroy]
	before_action :correct_user, only: :destroy

	def create
		@micropost = current_user.microposts.build(micropost_params)
		if @micropost.save
			if @micropost.content == 'stop'
				if Micropost.where(:user_id => current_user.id).find_by content: "start"
				aa = Micropost.where(:user_id => current_user.id).find_by content: "start"
					stop = @micropost.created_at.strftime('%H').to_f * 60 + @micropost.created_at.strftime('%M').to_f
					start = aa.created_at.strftime('%H').to_f * 60 + aa.created_at.strftime('%M').to_f
					calendar_flag = 0
					Calendar.where(:user_id => current_user.id).find_each do |day|
						if day.date == @micropost.created_at.strftime('%Y%m%d')
							
							Calendar.update_all(user_id: current_user.id, date: Micropost.where(:user_id => current_user.id).find_by(:content => "start").created_at.strftime('%Y%m%d'),time: ((stop - start) / 60).round(2) + day.time)
							calendar_flag = 1
						end
					end
					if calendar_flag == 0
						Calendar.create(user_id: current_user.id, date: Micropost.where(:user_id => current_user.id).find_by(:content => "start").created_at.strftime('%Y%m%d'),time: ((stop - start) / 60).round(2))
					end
				end
			end
		
		
			flash[:success] = "つぶやきました"
			redirect_to root_url
		else
			@feed_items = []
			@user = current_user
			render 'static_pages/home'
		end
	end

	def destroy
		@micropost.destroy
		redirect_to root_url
	end

	private
	
		def micropost_params
			params.require(:micropost).permit(:content)
		end

		def correct_user
			@micropost = current_user.microposts.find_by(id: params[:id])
			redirect_to root_url if @micropost.nil?
		end
end