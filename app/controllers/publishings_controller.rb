class PublishingsController < ApplicationController
  # before_action :authenticate_user

  def create
    campaign = Campaign.find params[:campaign_id]
    if campaign.publish!
      redirect_to campaign, notice: 'Campaign published'
    else
      byebug
      redirect_to campaign, alert: 'Can\'t publish the campaign'
    end
  end
end
