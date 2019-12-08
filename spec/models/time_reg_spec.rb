require 'rails_helper'

RSpec.describe TimeReg, type: :model do
  context 'Create time_reg' do
    it 'should be valid' do
      time_reg = build(:time_reg)
      expect(time_reg.valid?).to be(true)
    end
    it 'should change time_reg count by +1' do
      expect{
        time_reg = create(:time_reg)
      }.to change(TimeReg,:count).by(+1)
    end
    it 'should not be valid without date_reg' do
      time_reg = build(:time_reg, :wihout_time_reg)
      expect(time_reg.valid?).to be(false)
    end
    it 'should raise activerecord invalid' do
      expect{
        time_reg = TimeReg.create!()
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
  context 'Update time_reg' do
    before(:each) do
      @time_reg = create(:time_reg)
    end
    it 'should not update time_reg to nil' do
      expect{
        @time_reg.update!(time_reg: nil)
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
    it 'should not update day to nil' do
      expect{
        @time_reg.update!(day_id: nil)
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
  context 'Destroy time_reg' do
    before(:each) do
      @time_reg = create(:time_reg)
    end
    it 'should change time_reg count by -1' do
      expect{
        @time_reg.destroy
      }.to change(TimeReg,:count).by(-1)
    end
  end
end
