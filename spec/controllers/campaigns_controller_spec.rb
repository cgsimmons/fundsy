require 'rails_helper'

RSpec.describe CampaignsController, type: :controller do
  let(:user) { create(:user)}

    def signed_in
      request.session[:user_id] = user.id
    end

  describe '#new' do
    context 'with no user signed in' do
      it 'redirects to the home page' do
        get :new
        expect(response).to redirect_to(root_path)
      end
    end
    context 'with user signed in' do
      it 'renders the new template' do
        signed_in
        get :new
        expect(response).to render_template(:new)
      end
      it 'instantiates a new campaign object' do
        signed_in
        get :new
        expect(assigns(:campaign)).to be_a_new(Campaign)
      end
    end
  end

  describe '#create' do
    context 'with valid params' do
      def valid_request
        signed_in
        post :create, params: { campaign: attributes_for(:campaign)}
      end
      it 'saves a record to the database' do
        count_before = Campaign.count
        valid_request
        count_after = Campaign.count
        expect(count_after).to eq(count_before + 1)
      end
      it 'redirects to the campaign show page' do
        valid_request
        expect(response).to redirect_to(campaign_path(Campaign.last))
      end
    end
    context 'with invalid params' do
      def invalid_request
        signed_in
        post :create, params: { campaign: attributes_for(:campaign, title: nil)}
      end
      it 'doesn\'t save a record to the database' do
        count_before = Campaign.count
        invalid_request
        count_after = Campaign.count
        expect(count_after).to eq(count_before)
      end
      it 'renders the new template' do
        invalid_request
        expect(response).to render_template(:new)
      end
    end
  end

  describe '#show' do
    it 'renders the show template' do
      campaign = create(:campaign)
      get :show, params: { id: campaign.id }
      expect(response).to render_template(:show)
    end
    it 'sets an instance variable with the campaign whose id is passed' do
      campaign = create(:campaign)
      get :show, params: { id: campaign.id }
      expect(assigns(:campaign)).to eq(campaign)
    end

  end
end
