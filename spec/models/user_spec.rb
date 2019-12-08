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
    it 'should have 40 hours by default' do
      user = create(:user)
      expect(user.hours_per_week).to eq(40)
    end
    it 'should be user by default' do
      user = create(:user)
      expect(user.user?).to be(true)
    end
    it 'should not be admin or supervisor' do
      user = create(:user)
      expect(user.admin?).to be(false)
      expect(user.supervisor?).to be(false)
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
    it 'should update role to supervisor' do
      @user.update(role: 'supervisor')
      @user.reload
      expect(@user.role).to eq('supervisor')
    end
    it 'should update role to admin' do
      @user.update(role: 'admin')
      @user.reload
      expect(@user.role).to eq('admin')
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
    it 'should destroy every time_reg and days when destroying a user' do
      day = @user.days.create(date_reg: DateTime.now, month: DateTime.now.strftime('%m'), week: DateTime.now.strftime('%U'))
      time_reg = day.time_regs.create(time_reg: DateTime.now)
      day_id, time_id = day.id, time_reg.id
      @user.destroy
      expect{
        Day.find(day_id)
      }.to raise_error(ActiveRecord::RecordNotFound)
      expect{
        TimeReg.find(time_id)
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
