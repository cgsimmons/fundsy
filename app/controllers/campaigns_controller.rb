class CampaignsController < ApplicationController
  # before_action :authenticate_user, only: [:new, :create]

  def index
    @campaigns = Campaign.order(created_at: :desc)
  end
  def new
    @campaign = Campaign.new
    3.times {@campaign.rewards.build}
  end

  def create
    @campaign = Campaign.new campaign_params
    @campaign.user = current_user
    if @campaign.save
      redirect_to campaign_path(@campaign)
    else
      (3 - @campaign.rewards.size).times { @campaign.rewards.build}
      render :new
    end
  end

  def show
    @campaign = Campaign.find params[:id]
  end

  def campaign_params
    campaign_params = params.require(:campaign)
                            .permit([:title,
                                     :body,
                                     :goal,
                                     :end_date,
                                     :id,
                                     :_destroy,
                                     { rewards_attributes: [:amount,
                                                            :description]
                                      }
                                    ])
  end
end
