require 'rails_helper'

RSpec.describe User, type: :model do
  context 'Create user' do
    it 'should be valid' do
      user = build(:user)
      expect(user.valid?).to be(true)
    end
    it 'should change user count +1' do
      expect{
        user = create(:user)
      }.to change(User, :count).by(+1)
    end
    it 'should be invalid without name' do
      user = build(:user, :without_name)
      expect(user.valid?).to be(false)
    end
    it 'should be invalid without email' do
      user = build(:user, :without_email)
      expect(user.valid?).to be(false)
    end
    it 'should be invalid without password' do
      user = build(:user, :without_password)
      expect(user.valid?).to be(false)
    end
  end

  context 'Update user' do
    before(:each) do
      @user = create(:user)
    end

    it 'should update name to Changed Name' do
      @user.update(name: 'Changed Name')
      @user.reload
      expect(@user.name).to eq('Changed Name')
    end
    it 'should raise error when update name to nil' do
      expect{
        @user.update!(name: nil)
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
    it 'should raise error when update email to nil' do
      expect{
        @user.update!(email: nil)
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
    it 'should raise error when update password to nil' do
      expect{
        @user.update!(password: nil)
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  context 'Delete user' do
    before(:each) do
      @user = create(:user)
    end

    it 'should change user count by -1' do
      expect{
        @user.destroy
      }.to change(User,:count).by(-1)
    end
  end
end
