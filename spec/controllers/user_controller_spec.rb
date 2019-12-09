require 'rails_helper'

RSpec.describe UserController, type: :controller do
  context 'When user is not authenticated' do
    describe "POST #create" do
      it "returns http success" do
        post :create
        expect(response).to have_http_status(:redirect)
      end
    end

    describe "GET #show" do
      it "returns http success" do
        get :show, params: { id: 1 }
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
  context 'When user is authenticated' do
    before(:each) do
      @user = create(:user)
      sign_in @user
    end

    describe "POST #create" do
      it "returns http success" do
        post :create, params: { user: { 
          name: 'Test User', 
          email: 'email@email.com.br',
          password: '12345678',
          password_confirmation: '12345678'
        } }
        expect(response).to have_http_status(:success)
      end
      it "should change user count by +1" do
        expect{
          post :create, params: { user: { 
            name: 'Test User', 
            email: 'email@email.com.br',
            password: '12345678',
            password_confirmation: '12345678'
          } }
        }.to change(User, :count).by(+1)
      end
      it "should raise error when missing params" do
        expect{
          post :create
        }.to raise_error(ActionController::ParameterMissing)
      end
      it "returns url generator error" do
        expect{
          get :create
        }.to raise_error(ActionController::ParameterMissing)
        expect{
          put :create
        }.to raise_error(ActionController::ParameterMissing)
        expect{
          patch :create
        }.to raise_error(ActionController::ParameterMissing)
        expect{
          delete :create
        }.to raise_error(ActionController::ParameterMissing)
      end
      it "should raise error when model is invalid" do
        expect{
          post :create, params: { user: { 
            name: 'Test User', 
            password: '12345678',
            password_confirmation: '12345678'
          } }
        }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    describe "GET #show" do
      it "returns http success" do
        get :show, params: { id: @user.id }
        expect(response).to have_http_status(:success)
      end
      it "returns url generator error" do
        expect{
          put :show
        }.to raise_error(ActionController::UrlGenerationError)
        expect{
          get :show
        }.to raise_error(ActionController::UrlGenerationError)
        expect{
          post :show
        }.to raise_error(ActionController::UrlGenerationError)
        expect{
          delete :show
        }.to raise_error(ActionController::UrlGenerationError)
      end
    end

    describe "PUT #update" do
      it "should change name and email and hours_per_week" do
        put :update, params: { id: @user.id, user: {
          name: 'Changed Name',
          email: 'changed@email.com.br',
          hours_per_week: 22
        } }
        @user.reload
        expect(@user.name).to eq('Changed Name')
        expect(@user.email).to eq('changed@email.com.br')
        expect(@user.hours_per_week).to be(22)
      end
      it "returns url generator error" do
        expect{
          put :update
        }.to raise_error(ActionController::UrlGenerationError)
        expect{
          get :update
        }.to raise_error(ActionController::UrlGenerationError)
        expect{
          post :update
        }.to raise_error(ActionController::UrlGenerationError)
        expect{
          delete :update
        }.to raise_error(ActionController::UrlGenerationError)
      end
    end

    describe "DELETE #destroy" do
      it "returns url generator error" do
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
      it "returns http success" do
        delete :destroy, params: { id: @user.id }
        expect(response).to have_http_status(:success)
      end
      it "should change user count by -1" do
        expect{
          delete :destroy, params: { id: @user.id }
        }.to change(User, :count).by(-1)
      end
      it "should change day count" do
        day = create(:day, user: @user)
        create(:time_reg, day: day)
        @user.reload
        expect{
          delete :destroy, params: { id: @user.id }
        }.to change(Day, :count).by(-1)
      end
      it "should change time_reg count" do
        day = create(:day, user: @user)
        create(:time_reg, day: day)
        @user.reload
        expect{
          delete :destroy, params: { id: @user.id }
        }.to change(TimeReg, :count).by(-1)
      end
    end
  end
end
