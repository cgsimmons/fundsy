class PledgesController < ApplicationController
  before_action :authenticate_user, only: :create

  def create
    @campaign = Campaign.find_by(id: params[:campaign_id])
    pledge_params = params.require(:pledge).permit(:amount)
    @pledge = Pledge.new pledge_params
    @pledge.user = current_user
    @pledge.campaign = @campaign

    if @pledge.save
      redirect_to campaign_path(@campaign), notice: 'Pledge Successful!'
    else
      flash[:alert] = 'Pledge Unsuccessful'
      render 'campaigns/show'
    end

  end

end
