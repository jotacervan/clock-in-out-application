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
    it 'should change time_reg count by +2' do
      expect{
        day = create(:day)
        create(:time_reg, day: day)
        create(:time_reg, :end_day, day: day)
      }.to change(TimeReg,:count).by(+2)
    end
    it 'should update day to 8 hours and odd is false' do
      day = create(:day)
      create(:time_reg, day: day)
      day.reload
      create(:time_reg, :lunch_time, day: day)
      day.reload
      create(:time_reg, :end_lunch_time, day: day)
      day.reload
      create(:time_reg, :end_day, day: day)
      day.reload
      expect(day.hours).to eq("08:00")
      expect(day.odd).to be(false)
    end
    it 'should update day to 3 hours and odd is false' do
      day = create(:day)
      create(:time_reg, day: day)
      create(:time_reg, :lunch_time, day: day)
      day.reload
      expect(day.hours).to eq("03:00")
      expect(day.odd).to be(false)
    end
    it 'should update day to 3 hours and odd is true' do
      day = create(:day)
      create(:time_reg, day: day)
      day.reload
      create(:time_reg, :lunch_time, day: day)
      day.reload
      create(:time_reg, :end_lunch_time, day: day)
      day.reload
      expect(day.hours).to eq("03:00")
      expect(day.odd).to be(true)
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
  context 'Recalculation after create time_req' do
    before(:each) do
      @day = create(:day)
      @time1 = create(:time_reg, day: @day)
      @time2 = create(:time_reg, :lunch_time, day: @day)
      @time3 = create(:time_reg, :end_lunch_time, day: @day)
      @time4 = create(:time_reg, :end_day, day: @day)
    end
    
    it 'should update day hour to 3 and odd to false' do
      @time3.destroy
      @time4.destroy
      @day.reload
      expect(@day.hours).to eq("03:00")
      expect(@day.odd).to be(false)
    end

    it 'should update day hour to 3 and odd to true' do
      @time4.destroy
      @day.reload
      expect(@day.hours).to eq("03:00")
      expect(@day.odd).to be(true)
    end
  end
end
