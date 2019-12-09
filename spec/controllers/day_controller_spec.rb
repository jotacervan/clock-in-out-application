require 'rails_helper'

RSpec.describe DayController, type: :controller do
  context 'Unlogged user' do
    describe "GET #index" do
      it "returns http redirect" do
        get :index
        expect(response).to have_http_status(:redirect)
      end
    end

    describe "GET #show" do
      it "returns http redirect" do
        get :show, params: { id: 1 }
        expect(response).to have_http_status(:redirect)
      end
    end
  end

  context 'Logged user' do
    before(:each) do
      @user = create(:user)
      (0..3).each do |u|
        date = DateTime.now.beginning_of_day + u.days
        day = create(:day, user: @user, date_reg: date)
        create(:time_reg, time_reg: date + Rational(9,24), day: day)
        create(:time_reg, time_reg: date + Rational(12,24), day: day)
        create(:time_reg, time_reg: date + Rational(13,24), day: day)
        create(:time_reg, time_reg: date + Rational(18,24), day: day)
      end
      sign_in @user
    end

    describe "GET #index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET #show" do
      it "raise record not found error" do
        expect{
          get :show, params: { id: 1 }
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
      it "returns http success" do
        get :show, params: { id: @user.days.first.id }
        expect(response).to have_http_status(:success)
      end
      it "raise url generator error" do
        expect{
          get :show
        }.to raise_error(ActionController::UrlGenerationError)
        expect{
          post :show
        }.to raise_error(ActionController::UrlGenerationError)
        expect{
          put :show
        }.to raise_error(ActionController::UrlGenerationError)
        expect{
          patch :show
        }.to raise_error(ActionController::UrlGenerationError)
        expect{
          delete :show
        }.to raise_error(ActionController::UrlGenerationError)
      end
    end
  end

end
