require 'rails_helper'

RSpec.describe PledgesController, type: :controller do
  let(:user) { create(:user)}
  let(:campaign) { create(:campaign)}

  def signed_in
    request.session[:user_id] = user.id
  end

  describe '#create' do
    # before { request.session[:user_id] = user.id }
    context 'with valid parameters' do
      def valid_request
        signed_in
        post :create,
        params: { campaign_id: campaign.id, pledge: attributes_for(:pledge)}
      end
      it 'saves the pledge to the database' do
        count_before = Pledge.count
        valid_request
        count_after = Pledge.count
        expect(count_after).to eq(count_before + 1)
      end
      it 'redirects to campaign show page' do
        valid_request
        expect(response).to redirect_to(campaign)
      end
      it 'sets a flash message' do
        valid_request
        expect(flash[:notice]).to be
      end
    end
    context 'without valid parameters' do
      def invalid_request
        signed_in
        post :create,
        params: { campaign_id: campaign.id, pledge: attributes_for(:pledge, amount: 0)}
      end
      it 'doesn\'t save to the database' do
        count_before = Pledge.count
        invalid_request
        count_after = Pledge.count
        expect(count_after).to eq(count_before)
      end
      it 'renders the campaign show page' do
        invalid_request
        expect(response).to render_template('campaigns/show')
      end
      it 'sets an alert message'do
        invalid_request
        expect(flash[:alert]).to be
      end
    end
  end
end
