class CampaignsController < ApplicationController
  before_action :authenticate_user, only: [:new, :create]

  def new
    @campaign = Campaign.new
  end

  def create
    campaign_params = params.require(:campaign).permit([:title, :body, :goal, :end_date])
    @campaign = Campaign.new campaign_params
    @campaign.user = current_user
    if @campaign.save
      redirect_to campaign_path(@campaign)
    else
      render :new
    end
  end

  def show
    @campaign = Campaign.find params[:id]
  end
end
