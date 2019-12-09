require 'rails_helper'

RSpec.describe DashboardController, type: :controller do
  context 'Unlogged access' do
    describe "GET #index" do
      it "returns http redirect" do
        get :index
        expect(response).to have_http_status(:redirect)
      end
    end
  end

  context 'Logged User' do
    describe 'User with days in formations' do
      before(:each){
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
      }

      describe "GET #index" do
        it "returns http success" do
          get :index
          expect(response).to have_http_status(:success)
        end

        it "returns 0 days_count" do
          get :index
          expect(JSON.parse(response.body)['odd_days'].count).to be(0)
          expect(JSON.parse(response.body)['week_balance']).to eq("32:00")
        end
      end
    end
    describe 'User without days informations' do
      before(:each){
        @user = create(:user)
        sign_in @user
      }
      describe "GET #index" do
        it "returns http success" do
          get :index
          expect(response).to have_http_status(:success)
        end

        it "returns 0 days_count" do
          get :index
          expect(JSON.parse(response.body)['odd_days'].count).to be(0)
          expect(JSON.parse(response.body)['week_balance']).to eq("00:00")
        end
      end
    end
  end
end
