class MicropostsController < ApplicationController
	before_action :signed_in_user, only: [:create, :destroy]
	before_action :correct_user, only: :destroy

	def create
		@micropost = current_user.microposts.build(micropost_params)
		if @micropost.save
			if @micropost.content == 'stop'
				if Micropost.find_by(:user_id => current_user.id, :content => "start")
					start_time = Micropost.find_by(:user_id => current_user.id, :content => "start")
					if start_time.created_at.strftime('%Y%m%d') ==  @micropost.created_at.strftime('%Y%m%d')
						stop = @micropost.created_at.strftime('%H').to_f * 60 + @micropost.created_at.strftime('%M').to_f
						start = start_time.created_at.strftime('%H').to_f * 60 + start_time.created_at.strftime('%M').to_f
					else
						stop = @micropost.created_at.strftime('%H').to_f * 60 + @micropost.created_at.strftime('%M').to_f + 1440
						start = start_time.created_at.strftime('%H').to_f * 60 + start_time.created_at.strftime('%M').to_f
					end
					if Calendar.find_by(:user_id => current_user.id, :date => start_time.created_at.strftime('%Y%m%d'))
						current_calendar = Calendar.find_by(:user_id => current_user.id, :date => @micropost.created_at.strftime('%Y%m%d'))
							current_calendar.update(time: ((stop - start) / 60).round(2).to_f + current_calendar.time.to_f )							
					
					else
						Calendar.create(user_id: current_user.id, date: Micropost.where(:user_id => current_user.id).find_by(:content => "start").created_at.strftime('%Y%m%d'),time: ((stop - start) / 60).round(2).to_f)
					end
				end
			end
		
		
			flash[:success] = "つぶやきました"
			redirect_to root_url
		else
			@feed_items = []
			@user = current_user
			redirect_to root_url
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