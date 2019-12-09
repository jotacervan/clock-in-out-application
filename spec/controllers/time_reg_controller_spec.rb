require 'rails_helper'

RSpec.describe TimeRegController, type: :controller do
  context 'unlogged user' do
    describe "GET #index" do
      it "returns http success" do
        get :index, params: { day_id: 1 }
        expect(response).to have_http_status(:redirect)
      end
    end

    describe "GET #show" do
      it "returns http success" do
        get :show, params: { id: 1 }
        expect(response).to have_http_status(:redirect)
      end
    end

    describe "POST #create" do
      it "returns http success" do
        post :create
        expect(response).to have_http_status(:redirect)
      end
    end

    describe "PUT #update" do
      it "returns http success" do
        put :update, params: { id: 1 }
        expect(response).to have_http_status(:redirect)
      end
    end

    describe "DELETE #destroy" do
      it "returns http success" do
        delete :destroy, params: { id: 1 }
        expect(response).to have_http_status(:redirect)
      end
    end
  end
  context 'Logged user' do
    before(:each) do
      @user = create(:user)
      sign_in @user
    end

    describe "GET #index" do
      it "returns http success" do
        get :index, params: { day_id: 1 }
        expect(response).to have_http_status(:success)
      end
      it "returns an empty list" do
        get :index, params: { day_id: 1 }
        expect(JSON.parse(response.body).length).to be(0)
      end
      it "returns an url generator error" do
        expect{
          get :index
        }.to raise_error(ActionController::UrlGenerationError)
        expect{
          put :index
        }.to raise_error(ActionController::UrlGenerationError)
        expect{
          post :index
        }.to raise_error(ActionController::UrlGenerationError)
        expect{
          delete :index
        }.to raise_error(ActionController::UrlGenerationError)
      end
    end

    describe "DELETE #destroy" do
      before(:each) do
        @date = DateTime.now.beginning_of_day
        @day = create(:day, user: @user, date_reg: @date)
        @time = create(:time_reg, time_reg: @date + Rational(9,24), day: @day)
      end

      it "returns http success" do
        delete :destroy, params: { id: @time } 
        expect(response).to have_http_status(:success)
      end
      it "should change TimeReg count by -1" do
        expect{
          delete :destroy, params: { id: @time } 
        }.to change(TimeReg, :count).by(-1)
      end
      it "returns an url generator error" do
        expect{
          delete :destroy
        }.to raise_error(ActionController::UrlGenerationError)
        expect{
          get :destroy
        }.to raise_error(ActionController::UrlGenerationError)
        expect{
          post :destroy
        }.to raise_error(ActionController::UrlGenerationError)
        expect{
          put :destroy
        }.to raise_error(ActionController::UrlGenerationError)
      end
    end

    describe "PUT #update" do
      before(:each) do
        @date = DateTime.now.beginning_of_day
        @day = create(:day, user: @user, date_reg: @date)
        @time = create(:time_reg, time_reg: @date + Rational(9,24), day: @day)
      end

      it "returns http success" do
        put :update, params: { id: @time, time_reg: @date + Rational(12,24) } 
        expect(response).to have_http_status(:success)
      end

      it "returns http success without time_reg" do
        put :update, params: { id: @time } 
        expect(response).to have_http_status(:success)
      end

      it "returns http success without time_reg, but keep the same date" do
        put :update, params: { id: @time } 
        @time.reload
        same_date = @date + Rational(9,24)
        expect(@time.time_reg).to eq(same_date.utc)
      end

      it "update time to 12:00:00" do
        put :update, params: { id: @time.id, time_reg: @date + Rational(12,24) } 
        @time.reload
        new_date = @date + Rational(12,24)
        expect(@time.time_reg).to eq(new_date.utc)
      end

      it "returns an url generator error" do
        expect{
          get :update
        }.to raise_error(ActionController::UrlGenerationError)
        expect{
          put :update
        }.to raise_error(ActionController::UrlGenerationError)
        expect{
          post :update
        }.to raise_error(ActionController::UrlGenerationError)
        expect{
          delete :update
        }.to raise_error(ActionController::UrlGenerationError)
      end
    end

    describe "POST #create in an user with existing day entries" do
      before(:each) do
        @date = DateTime.now.beginning_of_day
        @day = create(:day, user: @user, date_reg: @date)
        create(:time_reg, time_reg: @date + Rational(9,24), day: @day)
      end
      it "returns http success" do
        post :create, params: { time_reg: @date + Rational(12,24) } 
        expect(response).to have_http_status(:success)
      end
      it "should change time_reg count by +1" do
        expect{
          post :create, params: { time_reg: @date + Rational(12,24) } 
        }.to change(TimeReg, :count).by(+1)
      end
      it "should change time_reg count by +1 without params" do
        expect{
          post :create
        }.to change(TimeReg, :count).by(+1)
      end
      it "should not change Day count" do
        expect{
          post :create, params: { time_reg: @date + Rational(12,24) } 
        }.to change(Day, :count).by(0)
      end
      it "should not change Day count without params" do
        expect{
          post :create
        }.to change(Day, :count).by(0)
      end
    end

    describe "POST #create in a new user" do
      it "returns http success" do
        post :create, params: { time_reg: "2019-12-08 12:00:00" }
        expect(response).to have_http_status(:success)
      end
      it "should change time_reg count by +1" do
        expect{
          post :create, params: { time_reg: "2019-12-08 12:00:00" }
        }.to change(TimeReg, :count).by(+1)
      end
      it "should change time_reg count by +1 without params" do
        expect{
          post :create
        }.to change(TimeReg, :count).by(+1)
      end
      it "should change Day count by +1 without params" do
        expect{
          post :create
        }.to change(Day, :count).by(+1)
      end
      it "should change Day count by +1" do
        expect{
          post :create, params: { time_reg: "2019-12-08 12:00:00" }
        }.to change(Day, :count).by(+1)
      end
    end

    describe "GET #show" do
      before(:each) do
        (0..3).each do |u|
          date = DateTime.now.beginning_of_day + u.days
          day = create(:day, user: @user, date_reg: date)
          create(:time_reg, time_reg: date + Rational(9,24), day: day)
          create(:time_reg, time_reg: date + Rational(12,24), day: day)
          create(:time_reg, time_reg: date + Rational(13,24), day: day)
          create(:time_reg, time_reg: date + Rational(18,24), day: day)
        end
      end

      it "returns http success" do
        expect{
          get :show, params: { id: 1 }
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
      it "returns the correct time reg" do
        get :show, params: { id: @user.days.first.time_regs.first.id }
        expect(response).to have_http_status(:success)
      end
      it "returns an url generator error" do
        expect{
          get :show
        }.to raise_error(ActionController::UrlGenerationError)
        expect{
          put :show
        }.to raise_error(ActionController::UrlGenerationError)
        expect{
          post :show
        }.to raise_error(ActionController::UrlGenerationError)
        expect{
          delete :show
        }.to raise_error(ActionController::UrlGenerationError)
      end
    end
  end
end
