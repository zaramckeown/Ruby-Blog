 class ProfileController < ApplicationController
 	before_action :authenticate, only: [:update]
	before_action :set_user, only: [:edit, :update]

  def show
	if params[:id]
	  @profile = Profile.find(params[:id])
	  
	  @url = "https://www.twitter.com/"
      @url.concat(@profile.twitter)   
	end
  end

  def edit
  end

 def update
    @profile = Profile.find(params[:id])
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to articles_path, notice: 'Profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
 end

  private
  def set_user
  	@profile = current_user.profile
  end

  def profile_params
    params.require(:profile).permit(:name, :birthday, :bio, :colour, :twitter)
  end
end